#ifndef XIAOMITOOL_H
#define XIAOMITOOL_H

#include <QMainWindow>

namespace Ui {
class XiaomiTool;
}

class XiaomiTool : public QMainWindow
{
    Q_OBJECT

public:
    explicit XiaomiTool(QWidget *parent = 0);
    ~XiaomiTool();

private slots:
    void on_RestoreB_clicked();

    void on_BackupB_clicked();

    void on_PushB_clicked();

    void on_CameraB_clicked();

    void on_pushButton_clicked();

    void on_APKB_clicked();

    void on_ShellB_clicked();

    void on_SRecB_clicked();

    void on_RunTB_clicked();

    void on_RecoveryB_clicked();

    void on_ZipB_clicked();

    void on_RootB_clicked();

    void on_FastBootB_clicked();

    void on_WDataB_clicked();

    void on_DeviceB_clicked();

    void on_ToolB_clicked();

private:
    Ui::XiaomiTool *ui;
};

#endif // XIAOMITOOL_H
