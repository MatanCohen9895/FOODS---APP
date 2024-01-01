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
    public partial class Form5 : Form
    {
        List<Questions> questions = new List<Questions>();
        public class Questions
        {
            public string question { get; set; }
            public string answer { get; set; }
        }

        public Form5()
        {
            InitializeComponent();
        }

        private void lblCounter_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void textPass_TextChanged(object sender, EventArgs e)
        {

        }

        private void Form5_Load(object sender, EventArgs e)
        {
            SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
            sqlCon.Open();
            SqlCommand command = new SqlCommand(null, sqlCon);

            command.CommandText =
               "SELECT Q.qusetion,A.answer " +
               " FROM Answers A INNER JOIN Questions Q ON A.questionNum = Q.questionNum " +
               " WHERE A.email = @mail ORDER BY NEWID()";

            SqlParameter mailParam = new SqlParameter("@mail", SqlDbType.VarChar, 20);
            Form4 newForm = new Form4();
            mailParam.Value = Form4.mailParamText;
            command.Parameters.Add(mailParam);


            command.Prepare();

            SqlDataReader reader = command.ExecuteReader();
            int counter = 0;
            while (reader.Read())
            {
                counter++;
                var labels = Controls.Find("question" + counter, true);
                if (labels.Length > 0)
                {
                    questions.Add(new Questions
                    {
                        answer = reader[1].ToString(),
                        question = reader[0].ToString()
                    });
                  
                   var label = (Label)labels[0];
                   label.Text = reader[0].ToString();
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int counter = 0;
            Boolean HasErrors = false;
            foreach (Questions item in questions)
            {
                counter++;
                var labels = Controls.Find("answer" + counter, true);
                if (labels.Length > 0)
                {
                    var label = (TextBox)labels[0];
                    if (label.Text != item.answer) HasErrors = true;
                }
            }

            if (!HasErrors)
            {
                // Update user password on db
                SqlConnection sqlCon = new SqlConnection(@"Data Source = DESKTOP-OG26RM1\SQLEXPRESS; 
                                                       Initial Catalog = food;
                                                       Integrated Security = True;");
                sqlCon.Open();
                SqlCommand command = new SqlCommand(null, sqlCon);

                command.CommandText =
                    "UPDATE Users SET password = @pass WHERE email = @mail";
                SqlParameter mail = new SqlParameter("@mail", SqlDbType.VarChar, 20);
                SqlParameter pass = new SqlParameter("@pass", SqlDbType.VarChar, 20);
                Form4 newForm = new Form4();
                mail.Value = Form4.mailParamText;
                pass.Value = textPass.Text;
                command.Parameters.Add(mail);
                command.Parameters.Add(pass);

                command.Prepare();
                command.ExecuteNonQuery();

                // Show success message and redirect to Form1
                ErrorMsg.Text = "";
                this.Visible = false;
                Form1 newForm2 = new Form1();
                newForm2.Show();
                MessageBox.Show("The user password updated successfuly!");
            }
            else
            {
                ErrorMsg.Text = "Error: One of the questions is invalid";
            }
        }
    }
}
