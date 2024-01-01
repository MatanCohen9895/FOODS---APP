using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace Ex3
{
    public partial class Admin_page : Form
    {
        public Admin_page()
        {
            InitializeComponent();

            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "select* from Users";


            command.Prepare();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                richTextBox7.Text = richTextBox7.Text
                   + "UserID: " + reader[0].ToString().Trim() + "\r\n"
                    + "email: " + reader[1].ToString().Trim() + "\r\n"
                    + "Birthdate: " + reader[2].ToString().Trim() + "\r\n"
                    + "[CityNum]: " + reader[3].ToString().Trim() + "\r\n"
                    + "FirstName: " + reader[4].ToString().Trim() + "\r\n"
                    + "lastname: " + reader[5].ToString().Trim() + "\r\n"
                    + "Gender: " + reader[6].ToString().Trim() + "\r\n"
                    + "password: " + reader[7].ToString().Trim() + "\r\n"
                    + "userType: " + reader[8].ToString().Trim() + "\r\n"
                    + "______________\r\n\r\n";
            }




        }

        private void button8_Click(object sender, EventArgs e)
        {
            {

                SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                           Initial Catalog = food;
                                                           Integrated Security = True;");
                sqlCon.Open();
                SqlCommand command = new SqlCommand("GetStoredProc", sqlCon);
                string kind = comboBox1.Text;
                string type = comboBox2.Text;
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@TypeOfRecipe", kind));
                command.Parameters.Add(new SqlParameter("@LevelOfRecipe", type));


                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    richTextBox6.Text = richTextBox6.Text
                         + "RecipeID: " + reader[0].ToString().Trim() + "\r\n"
                        + "PublisherID: " + reader[1].ToString().Trim() + "\r\n"
                        + "SubFoodCategoryID: " + reader[2].ToString().Trim() + "\r\n"
                        + "Title: " + reader[3].ToString().Trim() + "\r\n"
                        + "Description: " + reader[4].ToString().Trim() + "\r\n"
                         + "TotalTime: " + reader[5].ToString().Trim() + "\r\n"
                        + "Type: " + reader[6].ToString().Trim() + "\r\n"
                        + "Level: " + reader[7].ToString().Trim() + "\r\n"
                        + "PublicationDate: " + reader[8].ToString().Trim() + "\r\n"
                        + "______________________\r\n\r\n";

                }

            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "select* from noactivepuplisher";


            command.Prepare();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                richTextBox1.Text = richTextBox1.Text
                    + "UserID: " + reader[0].ToString().Trim() + "\r\n"
                    + "FirstName: " + reader[1].ToString().Trim() + "\r\n"
                    + "lastname: " + reader[2].ToString().Trim() + "\r\n"
                    + "Gender: " + reader[3].ToString().Trim() + "\r\n"
                    + "City: " + reader[4].ToString().Trim() + "\r\n"
                    + "______________________\r\n\r\n";
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "select* from RecipeStatistics";


            command.Prepare();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                richTextBox2.Text = richTextBox2.Text
                    + "Number of recipes: " + reader[0].ToString().Trim() + "\r\n"
                    + "level: " + reader[1].ToString().Trim() + "\r\n"
                    + "Type: " + reader[2].ToString().Trim() + "\r\n"
                    + "______________________\r\n\r\n";
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "select* from RecipeGrades";


            command.Prepare();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                richTextBox5.Text = richTextBox5.Text
                    + "Number of recipes: " + reader[0].ToString().Trim() + "\r\n"
                    + "Rating: " + reader[1].ToString().Trim() + "\r\n"
                    + "Type: " + reader[2].ToString().Trim() + "\r\n"
                    + "______________________\r\n\r\n";
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "select* from Bpublisher";


            command.Prepare();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                richTextBox3.Text = richTextBox3.Text
                    + "Publisher ID: " + reader[0].ToString().Trim() + "\r\n"
                     + "FirstName: " + reader[1].ToString().Trim() + "\r\n"
                    + "lastname: " + reader[2].ToString().Trim() + "\r\n"
                    + "amount of recipes: " + reader[3].ToString().Trim() + "\r\n"
                    + "______________________\r\n\r\n";
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            {

                SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                           Initial Catalog = food;
                                                           Integrated Security = True;");
                sqlCon.Open();
                SqlCommand command = new SqlCommand("GetStuser", sqlCon);
                string UID = textBox2.Text;

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@ID", UID));



                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    richTextBox4.Text = richTextBox4.Text
                         + "Fiest Name: " + reader[0].ToString().Trim() + "\r\n"
                        + "Last Name: " + reader[1].ToString().Trim() + "\r\n"
                        + "Number of recipes: " + reader[2].ToString().Trim() + "\r\n"
                        + "Lebel: " + reader[3].ToString().Trim() + "\r\n"
                        + "Type: " + reader[4].ToString().Trim() + "\r\n"
                        + "______________________\r\n\r\n";

                }

            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            String st = "DELETE FROM Comments WHERE Comments.Rating < 3";

            SqlCommand sqlcom = new SqlCommand(st, sqlCon);
           
            
                sqlcom.ExecuteNonQuery();
                MessageBox.Show("Bad comments delete successfuly!");
            
        }

        private void button5_Click(object sender, EventArgs e)
        {

            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            String st = "DELETE FROM Recipes WHERE RecipeID =" + textBox1.Text;

            SqlCommand sqlcom = new SqlCommand(st, sqlCon);
            
                sqlcom.ExecuteNonQuery();
                MessageBox.Show("delete successful");
            
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            this.Visible = false;
            open_page newForm = new open_page();
            newForm.Show();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "select* from Log";


            command.Prepare();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                richTextBox8.Text = richTextBox8.Text
                    + "isSuccessLogin: " + reader[0].ToString().Trim() + "\r\n"
                     + "loginTime: " + reader[1].ToString().Trim() + "\r\n"
                    + "email: " + reader[2].ToString().Trim() + "\r\n"
                    + "StatusLogin: " + reader[3].ToString().Trim() + "\r\n"
                    + "______________\r\n\r\n";
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "UPDATE Users SET userType = @usert WHERE UserID = @UserID";
            SqlParameter UserID = new SqlParameter("@UserID", SqlDbType.VarChar, 20);
            SqlParameter usert = new SqlParameter("@usert", SqlDbType.VarChar, 20);
            Form4 newForm = new Form4();
            UserID.Value = textBox3.Text;
            usert.Value = "admin";
            command.Parameters.Add(UserID);
            command.Parameters.Add(usert);

            command.Prepare();
            command.ExecuteNonQuery();

            // Show success message 
            
            MessageBox.Show("success!");


         
        }
}
    
}
