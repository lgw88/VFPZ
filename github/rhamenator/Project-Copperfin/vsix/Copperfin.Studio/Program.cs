using System;
using System.Windows.Forms;

namespace Copperfin.VisualStudio;

internal static class Program
{
    [STAThread]
    private static void Main(string[] args)
    {
        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);

        using var form = new StudioMainForm();
        foreach (var candidate in args)
        {
            if (string.IsNullOrWhiteSpace(candidate))
            {
                continue;
            }

            form.OpenDocument(candidate);
        }

        Application.Run(form);
    }
}
