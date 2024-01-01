
namespace Ex3
{
    partial class Form2
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
            this.lblCounter = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.LoginAttempts = new System.Windows.Forms.RichTextBox();
            this.linkLabel1 = new System.Windows.Forms.LinkLabel();
            this.SuspendLayout();
            // 
            // lblCounter
            // 
            this.lblCounter.AutoSize = true;
            this.lblCounter.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCounter.ForeColor = System.Drawing.Color.DeepSkyBlue;
            this.lblCounter.Location = new System.Drawing.Point(34, 41);
            this.lblCounter.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.lblCounter.Name = "lblCounter";
            this.lblCounter.Size = new System.Drawing.Size(897, 73);
            this.lblCounter.TabIndex = 1;
            this.lblCounter.Text = "You\'ve logged in successfully";
            this.lblCounter.Click += new System.EventHandler(this.lblCounter_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(46, 134);
            this.button1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(238, 36);
            this.button1.TabIndex = 2;
            this.button1.Text = "Show login attempts";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // LoginAttempts
            // 
            this.LoginAttempts.Location = new System.Drawing.Point(46, 203);
            this.LoginAttempts.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.LoginAttempts.Name = "LoginAttempts";
            this.LoginAttempts.Size = new System.Drawing.Size(1084, 445);
            this.LoginAttempts.TabIndex = 3;
            this.LoginAttempts.Text = "";
            // 
            // linkLabel1
            // 
            this.linkLabel1.AutoSize = true;
            this.linkLabel1.Location = new System.Drawing.Point(962, 32);
            this.linkLabel1.Name = "linkLabel1";
            this.linkLabel1.Size = new System.Drawing.Size(197, 25);
            this.linkLabel1.TabIndex = 4;
            this.linkLabel1.TabStop = true;
            this.linkLabel1.Text = "Back to home page";
            this.linkLabel1.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel1_LinkClicked);
            // 
            // Form2
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1200, 703);
            this.Controls.Add(this.linkLabel1);
            this.Controls.Add(this.LoginAttempts);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.lblCounter);
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "Form2";
            this.Text = "Form2";
            this.Load += new System.EventHandler(this.Form2_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblCounter;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.RichTextBox LoginAttempts;
        private System.Windows.Forms.LinkLabel linkLabel1;
    }
}