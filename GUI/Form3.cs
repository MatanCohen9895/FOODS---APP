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

    public partial class Form3 : Form
    {
        List<Questions> questions = new List<Questions>();
        public class Questions
        {
            public int questionNum { get; set; }
            public string question { get; set; }
        }
        public Form3()
        {
            InitializeComponent();

            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "SELECT * FROM City";


            command.Prepare();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                richTextBox1.Text = richTextBox1.Text
                    + "City Number: " + reader[0].ToString().Trim() + "\r\n"
                    + "City Name: " + reader[1].ToString().Trim() + "\r\n"
                      + "_________\r\n\r\n";

            }




        }

        private void lblCounter_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void Form3_Load(object sender, EventArgs e)
        {
            // Set questions on form
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand("SELECT TOP 5 * FROM Questions ORDER BY NEWID()", sqlCon);
            SqlDataReader reader = command.ExecuteReader();
            int counter = 0;
            while (reader.Read())
            {
                counter++;
                var labels = Controls.Find("question" + counter, true);
                if (labels.Length > 0)
                {
                    questions.Add(new Questions {
                        questionNum = int.Parse(reader[0].ToString()),
                        question = reader[1].ToString()
                    });
                    var label = (Label)labels[0];
                    label.Text = reader[1].ToString();
                }
            }
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged_1(object sender, EventArgs e)
        {

        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged_2(object sender, EventArgs e)
        {

        }

        private void label9_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            // Add user to db
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
                "INSERT INTO Users(email,firstName,lastName,birthDate,password,userType,UserID,CityNum,Gender)" +
                "VALUES(@mail, @firstName, @lastName, @birthDate, @pass, 'LoginUser',@UserID,@CityNum,@Gender)";
            SqlParameter mail = new SqlParameter("@mail", SqlDbType.VarChar, 20);
            SqlParameter firstName = new SqlParameter("@firstName", SqlDbType.VarChar, 20);
            SqlParameter lastName = new SqlParameter("@lastName", SqlDbType.VarChar, 20);
            SqlParameter birthDate = new SqlParameter("@birthDate", SqlDbType.DateTime, 0);
            SqlParameter pass = new SqlParameter("@pass", SqlDbType.VarChar, 20);
            SqlParameter UserID = new SqlParameter("@UserID", SqlDbType.SmallInt);
            SqlParameter CityNum = new SqlParameter("@CityNum", SqlDbType.SmallInt);
            SqlParameter Gender = new SqlParameter("@Gender", SqlDbType.Char,1);
            mail.Value = textMail.Text;
            firstName.Value = textFirstname.Text;
            lastName.Value = textLastname.Text;
            birthDate.Value = textBirthdate.Text;
            pass.Value = textPass.Text;
            UserID.Value = Int16.Parse( textuserid.Text);
            CityNum.Value = Int16.Parse(textcitynum.Text);
            Gender.Value = combogender.Text;

            command.Parameters.Add(mail);
            command.Parameters.Add(firstName);
            command.Parameters.Add(lastName);
            command.Parameters.Add(birthDate);
            command.Parameters.Add(pass);
            command.Parameters.Add(UserID);
            command.Parameters.Add(CityNum);
            command.Parameters.Add(Gender);

            command.Prepare();
            command.ExecuteNonQuery();

            // Add answers to db
            int counter = 0;
            command.CommandText =
                "INSERT INTO Answers(answer, email, questionNum,UserID)" +
                "VALUES(@answer, @mail2, @questionNum,@UserIDa)";
            SqlParameter mail2 = new SqlParameter("@mail2", SqlDbType.VarChar, 20);
            SqlParameter answer = new SqlParameter("@answer", SqlDbType.VarChar, 20);
            SqlParameter questionNum = new SqlParameter("@questionNum", SqlDbType.VarChar, 20);
            SqlParameter UserIDa = new SqlParameter("@UserIDa", SqlDbType.SmallInt);

            UserIDa.Value = textuserid.Text;
            command.Parameters.Add(mail2);
            command.Parameters.Add(answer);
            command.Parameters.Add(questionNum);
            command.Parameters.Add(UserIDa);
            command.Prepare();
            foreach (Questions item in questions)
            {
                counter++;
                mail2.Value = textMail.Text;
                var labels = Controls.Find("answer" + counter, true);
                if (labels.Length > 0)
                {
                    var label = (TextBox)labels[0];
                    answer.Value = label.Text;
                }
                questionNum.Value = item.questionNum;


                command.ExecuteNonQuery();
            }

            this.Visible = false;
            Form1 newForm = new Form1();
            newForm.Show();
            MessageBox.Show("The user added successfuly!");
        }
    }
}
