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
    public partial class Form4 : Form
    {
        private object sqlAd;
        private object txtSql;
        SqlConnection sqlCon;
        public static string mailParamText = "";
        public Form4()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
               "SELECT * FROM Users WHERE email = @mail";
            SqlParameter mailParam = new SqlParameter("@mail", SqlDbType.VarChar, 20);
            mailParam.Value = textMail.Text;
            command.Parameters.Add(mailParam);
            

            command.Prepare();

            SqlDataReader reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                mailParamText = textMail.Text;
                ErrorMsg.Text = "";
                this.Visible = false;
                Form5 newForm = new Form5();
                newForm.Show();
            }
            else
            {
                ErrorMsg.Text = "Error: The user is not exist";
            }
            reader.Close();
        }

        private void lblCounter_Click(object sender, EventArgs e)
        {

        }
    }
}
