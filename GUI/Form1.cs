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
    public partial class Form1 : Form
    {
        private object sqlAd;
        private object txtSql;
        SqlConnection sqlCon;
        public static string mailParamText = "";
        public static string flag = "";

        public Form1()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {
            flag = "Guest";
            this.Visible = false;
            open_page newForm = new open_page();
            newForm.Show();

        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
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
               "SELECT * FROM Users as U   WHERE U.email = @mail AND U.password = @pass";
            SqlParameter mailParam = new SqlParameter("@mail", SqlDbType.VarChar, 20);
            SqlParameter passwordParam = new SqlParameter("@pass", SqlDbType.VarChar, 20);
            mailParam.Value = textMail.Text;
            passwordParam.Value = textPass.Text;
            command.Parameters.Add(mailParam);
            command.Parameters.Add(passwordParam);

            command.Prepare();

            SqlDataReader reader = command.ExecuteReader();
           
            
            Boolean hasRows = reader.HasRows;
           
            if (hasRows)
            {
                reader.Read();

                String type = reader.GetString(8);
                

                mailParamText = textMail.Text;
                ErrorMsg.Text = "";
                if  (type == "admin")
                    flag = "admin";
                else
                    flag = "User";
                this.Visible = false;
                open_page newForm = new open_page();
                newForm.Show();
            }
            else
            {
                ErrorMsg.Text = "Error: Email or Password is invalid!";
            }
            

            // Add log to db
            SqlCommand command2 = new SqlCommand(null, sqlCon);
            command2.CommandText =
                "INSERT INTO Log(loginTime, email, isSuccessLogin, StatusLogin)" +
                "VALUES(GETDATE(), @mail, @isSuccessLogin, @StatusLogin)";

            SqlParameter email = new SqlParameter("@mail", SqlDbType.VarChar, 20);
            SqlParameter isSuccessLogin = new SqlParameter("@isSuccessLogin", SqlDbType.Bit, 0);
            SqlParameter StatusLogin = new SqlParameter("@StatusLogin", SqlDbType.VarChar, 20);
           




            
            email.Value = textMail.Text;
            isSuccessLogin.Value = hasRows ? 1 : 0;
            StatusLogin.Value = hasRows ? "Success" : "Fail";
            command2.Parameters.Add(email);
            command2.Parameters.Add(isSuccessLogin);
            command2.Parameters.Add(StatusLogin);
            reader.Close();
            command2.Prepare();
            command2.ExecuteNonQuery();

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void linkLabel2_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            this.Visible = false;
            Form3 newForm = new Form3();
            newForm.Show();
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void linkLabel3_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            this.Visible = false;
            Form4 newForm = new Form4();
            newForm.Show();
        }
    }
}
