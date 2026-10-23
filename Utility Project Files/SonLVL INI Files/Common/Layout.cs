using System;
using System.Drawing;
using SonicRetro.SonLVL.API;

// Layout format for the Sonic 1 Clean Engine (Project 128 base) with word chunk IDs:
//   - one file per act, no header
//   - 16 rows; each row = FG (128 words) followed by BG (128 words)
//   - each entry is a big-endian 16-bit chunk ID (00 XX for IDs up to $FF)
//   - total size = $2000 bytes
//
// INI usage:
//   layoutfmt=Custom
//   layoutcodefile=Common/Layout.cs
//   layoutcodetype=MyLayouts.LayoutWord
namespace MyLayouts
{
	public class LayoutWord : LayoutFormatCombined
	{
		private const int Columns = 128;	// chunks per row, per plane
		private const int Rows = 16;		// rows in the layout
		private const int PlaneRowBytes = Columns * 2;	// $100 bytes
		private const int RowBytes = PlaneRowBytes * 2;	// $200 bytes (FG + BG)

		// The editor needs to know the largest layout this format can hold
		public override Size MaxSize { get { return new Size(Columns, Rows); } }

		private static ushort ReadWord(byte[] data, int offset)
		{
			if (offset + 1 >= data.Length)
				return 0;	// treat missing data as chunk 0
			return (ushort)((data[offset] << 8) | data[offset + 1]);
		}

		public override void ReadLayout(byte[] rawdata, LayoutData layout)
		{
			layout.FGLayout = new ushort[Columns, Rows];
			layout.BGLayout = new ushort[Columns, Rows];

			for (int y = 0; y < Rows; y++)
			{
				int rowStart = y * RowBytes;
				for (int x = 0; x < Columns; x++)
				{
					layout.FGLayout[x, y] = ReadWord(rawdata, rowStart + x * 2);
					layout.BGLayout[x, y] = ReadWord(rawdata, rowStart + PlaneRowBytes + x * 2);
				}
			}
		}

		public override void WriteLayout(LayoutData layout, out byte[] rawdata)
		{
			rawdata = new byte[Rows * RowBytes];

			int fgw = layout.FGLayout.GetLength(0);
			int fgh = layout.FGLayout.GetLength(1);
			int bgw = layout.BGLayout.GetLength(0);
			int bgh = layout.BGLayout.GetLength(1);

			for (int y = 0; y < Rows; y++)
			{
				int rowStart = y * RowBytes;
				for (int x = 0; x < Columns; x++)
				{
					ushort fg = (x < fgw && y < fgh) ? layout.FGLayout[x, y] : (ushort)0;
					ushort bg = (x < bgw && y < bgh) ? layout.BGLayout[x, y] : (ushort)0;

					int fgOff = rowStart + x * 2;
					int bgOff = rowStart + PlaneRowBytes + x * 2;

					rawdata[fgOff] = (byte)(fg >> 8);
					rawdata[fgOff + 1] = (byte)fg;
					rawdata[bgOff] = (byte)(bg >> 8);
					rawdata[bgOff + 1] = (byte)bg;
				}
			}
		}
	}
}
