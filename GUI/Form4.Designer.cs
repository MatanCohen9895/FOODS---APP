
namespace Ex3
{
    partial class Form4
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.textMail = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.ErrorMsg = new System.Windows.Forms.Label();
            this.lblCounter = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(488, 227);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(0, 25);
            this.label1.TabIndex = 11;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(472, 222);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 25);
            this.label2.TabIndex = 12;
            this.label2.Text = "Email";
            // 
            // textMail
            // 
            this.textMail.Location = new System.Drawing.Point(594, 222);
            this.textMail.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.textMail.Name = "textMail";
            this.textMail.Size = new System.Drawing.Size(148, 31);
            this.textMail.TabIndex = 13;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(632, 334);
            this.button1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(112, 36);
            this.button1.TabIndex = 17;
            this.button1.Text = "Next";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // ErrorMsg
            // 
            this.ErrorMsg.AutoSize = true;
            this.ErrorMsg.ForeColor = System.Drawing.Color.Red;
            this.ErrorMsg.Location = new System.Drawing.Point(430, 412);
            this.ErrorMsg.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.ErrorMsg.Name = "ErrorMsg";
            this.ErrorMsg.Size = new System.Drawing.Size(0, 25);
            this.ErrorMsg.TabIndex = 19;
            // 
            // lblCounter
            // 
            this.lblCounter.AutoSize = true;
            this.lblCounter.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCounter.ForeColor = System.Drawing.Color.DeepSkyBlue;
            this.lblCounter.Location = new System.Drawing.Point(202, 66);
            this.lblCounter.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.lblCounter.Name = "lblCounter";
            this.lblCounter.Size = new System.Drawing.Size(815, 73);
            this.lblCounter.TabIndex = 20;
            this.lblCounter.Text = "Restore password - Step 1";
            this.lblCounter.Click += new System.EventHandler(this.lblCounter_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(124, 221);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(325, 25);
            this.label3.TabIndex = 21;
            this.label3.Text = "Please insert your email address";
            // 
            // Form4
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1200, 703);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.lblCounter);
            this.Controls.Add(this.ErrorMsg);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.textMail);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "Form4";
            this.Text = "Form4";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textMail;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label ErrorMsg;
        private System.Windows.Forms.Label lblCounter;
        private System.Windows.Forms.Label label3;
    }
}