#ifndef OTOOLS_H
#define OTOOLS_H

#include <QMainWindow>

namespace Ui {
class OTools;
}

class OTools : public QMainWindow
{
    Q_OBJECT

public:
    explicit OTools(QWidget *parent = 0);
    ~OTools();

private slots:
    void on_BackupB_clicked();

    void on_Select_clicked();

    void on_bacon_clicked();

    void on_find7_clicked();

    void on_find5_clicked();

    void on_n1_clicked();

    void on_RestoreB_clicked();

    void on_SelectF_clicked(bool checked);

    void on_SelectF_clicked();

    void on_actionDisclaimer_triggered();

    void on_actionAbout_triggered();

    void on_actionUpdate_triggered();

    void on_SelectBack_clicked();

    void on_SelectPull_clicked();

    void on_PushB_clicked();

    void on_PullB_clicked();

    void on_CamB_clicked();

    void on_pushButton_3_clicked();

    void on_UnlockB_clicked();

    void on_LockB_clicked();

    void on_FBootB_clicked();

    void on_FlashBootB_clicked();

    void on_RecoveryB_clicked();

    void on_FBFlashB_clicked();

    void on_RootB_clicked();

    void on_LogoB_clicked();

    void on_EfsB_clicked();

    void on_SRECB_clicked();

    void on_ShellB_clicked();

    void on_ApkB_clicked();

private:
    Ui::OTools *ui;
};

#endif // OTOOLS_H
