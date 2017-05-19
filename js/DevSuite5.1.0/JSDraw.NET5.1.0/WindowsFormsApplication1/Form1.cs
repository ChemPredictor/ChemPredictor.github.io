using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Scilligence.JSDraw.Net;
using Scilligence.MolEngine;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        string structure;

        public Form1()
        {
            InitializeComponent();

            Scilligence.MolEngine.Common.Security.AddLicense(@"# Licensed to: (Evaluation)
# Product: JSDrawNET, Ultra
# Modules: 
# SN: 0107a5ec-1033-49bf-a4dc-5f0fd1fb86e7
# Expiration Date: 2016-Dec-23
MDIwMDAzMDQwMzExMDgxMDExMDkxNDE0MTUxMTA4MDAwODA0MDQwODE1MDMxMjEwMTExMTA1MDkwMjAz
MDAwNzAyMTUwODA4MDExMjA1MDUxMDAwMDQxMDA5MDIwMDE1MDMwNjExMTUxMzAwMTUxMTE1MDAwNTA4
MDQxMjE0MTIwODA2MTMxMDE1MDIxMjEwMDgxNTE0MTMwMzA4MDYwODAxMTUwMjAzMTQxMDA0MDIwMjAw
MDUwNDA3MDMxMDA1MDYxMjEwMTQxNTA1MDkwMjAwMDMwOTE0MDYwMDA1MDQxMTEyMDgwNTA3MTEwNDEy
MDMwMTA1MDkwMjA2MDAwMDEyMTQxMDA0MDUwMTAyMDExNTA1MTQxMzA0MDEwNzA4MTEwNzE0MDUwMDEy
MTMwNDA4MDcxMzA2MTQxMDE1MDIwODEzMDgxMDA4MDAwMjEzMTMwMjA1MDkwNTA4MDQxMDAxMDcwOTA2
MDkxMDExMTUwMDAyMDAwODA1MDcwODAxMDkwMTExMTExMzEwMTIwODA2MDQwNjEwMDUwNDExMDMwMTEx
MDAwMTE0MDgwODA3MDUxMjA4MDAwMjE1MTUwMTExMDcxMjA4MDExNTAxMDMwNzE1MTExNTA2MTExMzAw
MDgwMzAyMDIxNDA5MDkwOTA4MDMxMzEzMDcwMjEzMTMwOTE1MTQxMDA0MTExMjEzMDQxNDA3MDQwNjEz
MTAxMTAxMDcwMjA5MDkwNDE0MTAwNDA4MTAwNDA1MDkxMDEyMDAwOTAyMDMwMjAzMDEwNzA2MTIwOTEz
MDgwMTAzMDIwODAwMDMwNjExMTAwNTExMDYwNTE0MDUwMTEwMDgxMjEwMDcwODA0MDMwNzEyMDAwODAw
MDEwNjEwMDUwNjA4MTQxMDEzMTIwOTA3MDcwMTA2MTEwMzA2MDkwMzAzMTQwNjEwMDcwODA2MDEwMjA0
MTQwMzA1MDMxMjExMDYwMDAzMTAxMjA0MTIxMTA4MDExNTAxMDgxNTEwMTQxMDAyMTMxMzAxMDExMTAx
MTMwNTExMDUwMTAwMDAwNTA5MTAwMzAyMTUxNTA0MDYxNDAxMDYwODA0MTMwODAwMTMxNTA3MDgwMDEz
MTMxMTA5MDkwNDEzMDMwNzA5MTUxMTAxMTQwNjA1MTExNTA4MTMxMDA4MDAwODA1MTEwMDEwMTAwNDEw
MDYxNDEwMDIwNzA4MTQwNzAwMTAwNDA1MDYwNDAxMDUwMjA2MTEwNTE0MTIxNTA5MDQwMjE1MTAwMzE1
MDQwNTEwMDAxMDEzMDcxMzExMTIxMzA0MTAxMDE1MDcxMDAzMDUxMjEwMDEwMDEwMDgwOTA5MDkwMjA4
MTExNDEzMTUwNjAxMDIxMzE1MDkwMjA4MDgwNzA1MDEwOTAzMTMwODAzMTUwNDA4MDIwNzEzMTIwNjAy
MTUxMDE1MDIxMDE0MTEwMDEyMDIwMjA0MTQwNDA2MDMwNDEyMDMwOTAyMDgxMDA4MTQxMzE0MTUxNDAw
MDQxMDA5MDAwNzE1MDYwNjAxMDcwODAyMTEwMTE1MDIxNTE0MTUwMDAyMTMwNjE1MDMwNTA2MDMwMjEx
MDkwNzAwMTExMzEyMTUwNw==
"
);
            Lic.InitJSDrawLicense();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            PopupEditor pe = PopupEditor.Show(structure, this);
            if (pe.Result != System.Windows.Forms.DialogResult.OK)
                return;

            structure = pe.Html;
            Molecule m = Molecule.Read(structure);
            string smiles = m.ToString("smiles");
            string molfile = m.ToString("molfile");
            pictureBox1.Image = m.ToImage(pictureBox1.ClientSize.Width, pictureBox1.ClientSize.Height, 10);
        }
    }
}
