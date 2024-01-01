using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Ex3
{
    public partial class Form2 : Form
    {
        SqlConnection sqlCon;

        public Form2()
        {
            InitializeComponent();
        }

        private void lblCounter_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "SELECT * FROM Log WHERE email = @mail";
            SqlParameter mailParam = new SqlParameter("@mail", SqlDbType.VarChar, 20);
            Form1 newForm = new Form1();
            mailParam.Value = Form1.mailParamText;
            command.Parameters.Add(mailParam);

            command.Prepare();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                LoginAttempts.Text = LoginAttempts.Text
                    + "Login time: " + reader[1].ToString().Trim() + "\r\n"
                    + "Status login: " + reader[3].ToString().Trim() + "\r\n"
                    + "______________________\r\n\r\n";
            }
        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            this.Visible = false;
            open_page newForm = new open_page();
            newForm.Show();
        }
    }
}
