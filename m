Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF095292937
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Oct 2020 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgJSOXr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Oct 2020 10:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728344AbgJSOXr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 19 Oct 2020 10:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603117424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=hist2VJBj3Hg6pe/kvjFzOIwP9Y1Urk91DbUes32Z1o=;
        b=FI7YRBDq36ECKldcig8lKOp//TdzpEbFLey4iAYZqQt8pG9823s+ljeyWkx+1FGsgUAAWJ
        OtYsczSGhrJsdiqM2rPfOPQGm60yENfhGHaQXNQDvmT5iWUeysnV7QqlUAJIoMHtJQ+kd+
        jQNd68jixf3utWa5sCBMtdKMlCapTC4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-C8Pjd6-YNgabraQLxYbRAg-1; Mon, 19 Oct 2020 10:23:41 -0400
X-MC-Unique: C8Pjd6-YNgabraQLxYbRAg-1
Received: by mail-qv1-f70.google.com with SMTP id l8so71613qvz.2
        for <linux-scsi@vger.kernel.org>; Mon, 19 Oct 2020 07:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hist2VJBj3Hg6pe/kvjFzOIwP9Y1Urk91DbUes32Z1o=;
        b=SjUh6KqgqFEcFBPXJ6oxzoS1CNoLhJhHXe6cPi4rh7tYaDmEk+A/SqJxPb0Xh+2yZH
         8CWeR4qmu7zmUW1VP8/leCSr2T0RSPgjk+PTggqjnEaD8GMi4ljCzQjlOq1mOdzLKRWZ
         rmQrxnCLJcfkWhwIBvvb/tmLZeg9PII5F1w3k2fJUn7hkEDghW5//NeoN5Va/wFIOjVd
         4Ix2A7lK/dFGbUC2UFCe1ys0oPwiAAX4DdgCxztGKRObOod5H1mbxwT8PD7b9BG+w93z
         Xv1EB9oeY/+ucKpc+VL6FfsreMOReWyCV79n/Wc7Y/uJr0a1aKlxqWHE85erN9OhFswd
         HXkA==
X-Gm-Message-State: AOAM530TH8l56O+FwvjiMu9ljXs3XGAyNlkgqxN/xqecLXrTGh7qrJVD
        /8O+fU2qkkGzr/iGb5/z/8xZMdjudFTG2l+yUJ1V2GY2ndI+qpxdseKY6Rv/XQkTEFxKHCu6QNm
        XtGjUftyl8kjmESksB+e8cA==
X-Received: by 2002:a0c:8d05:: with SMTP id r5mr2084332qvb.31.1603117420311;
        Mon, 19 Oct 2020 07:23:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSqjcv+5ZQBO/s6MPbADZWWRy0Omeq3E6TAGYS2mwIpc75suoZG1EYKN/uea08lKO8wgI3hw==
X-Received: by 2002:a0c:8d05:: with SMTP id r5mr2084293qvb.31.1603117419983;
        Mon, 19 Oct 2020 07:23:39 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 69sm79851qko.48.2020.10.19.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:23:39 -0700 (PDT)
From:   trix@redhat.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        subbu.seetharaman@broadcom.com, ketan.mukadam@broadcom.com,
        jitendra.bhivare@broadcom.com, skashyap@marvell.com,
        jhasan@marvell.com, hare@suse.de, don.brace@microchip.com,
        linux@highpoint-tech.com, brking@us.ibm.com,
        intel-linux-scu@intel.com, artur.paszkiewicz@intel.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        yokota@netlab.is.tsukuba.ac.jp, njavali@marvell.com,
        Kai.Makisara@kolumbus.fi, willy@infradead.org
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, storagedev@microchip.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: remove unneeded break
Date:   Mon, 19 Oct 2020 07:23:33 -0700
Message-Id: <20201019142333.16584-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return or goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c |  1 -
 drivers/scsi/be2iscsi/be_mgmt.c     |  4 ----
 drivers/scsi/bnx2fc/bnx2fc_hwi.c    |  1 -
 drivers/scsi/fcoe/fcoe.c            |  1 -
 drivers/scsi/hpsa.c                 |  1 -
 drivers/scsi/hptiop.c               |  1 -
 drivers/scsi/ipr.c                  |  1 -
 drivers/scsi/isci/phy.c             |  2 --
 drivers/scsi/lpfc/lpfc_debugfs.c    | 12 ++++--------
 drivers/scsi/lpfc/lpfc_init.c       |  1 -
 drivers/scsi/lpfc/lpfc_scsi.c       |  1 -
 drivers/scsi/lpfc/lpfc_sli.c        |  3 ---
 drivers/scsi/mvumi.c                |  1 -
 drivers/scsi/pcmcia/nsp_cs.c        |  2 --
 drivers/scsi/qla2xxx/qla_mbx.c      |  1 -
 drivers/scsi/st.c                   |  1 -
 drivers/scsi/sym53c8xx_2/sym_hipd.c |  1 -
 17 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index f923ed019d4a..ed034192b3c3 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -269,7 +269,6 @@ static void asd_task_tasklet_complete(struct asd_ascb *ascb,
 	case TA_I_T_NEXUS_LOSS:
 		opcode = dl->status_block[0];
 		goto Again;
-		break;
 	case TF_INV_CONN_HANDLE:
 		ts->resp = SAS_TASK_UNDELIVERED;
 		ts->stat = SAS_DEVICE_UNKNOWN;
diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index 96d6e384b2b2..0d4928567265 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -1244,18 +1244,14 @@ beiscsi_adap_family_disp(struct device *dev, struct device_attribute *attr,
 	case OC_DEVICE_ID2:
 		return snprintf(buf, PAGE_SIZE,
 				"Obsolete/Unsupported BE2 Adapter Family\n");
-		break;
 	case BE_DEVICE_ID2:
 	case OC_DEVICE_ID3:
 		return snprintf(buf, PAGE_SIZE, "BE3-R Adapter Family\n");
-		break;
 	case OC_SKH_ID1:
 		return snprintf(buf, PAGE_SIZE, "Skyhawk-R Adapter Family\n");
-		break;
 	default:
 		return snprintf(buf, PAGE_SIZE,
 				"Unknown Adapter Family: 0x%x\n", dev_id);
-		break;
 	}
 }
 
diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 08992095ce7a..b37b0a9ec12d 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -770,7 +770,6 @@ static void bnx2fc_process_unsol_compl(struct bnx2fc_rport *tgt, u16 wqe)
 			} else
 				printk(KERN_ERR PFX "SRR in progress\n");
 			goto ret_err_rqe;
-			break;
 		default:
 			break;
 		}
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 0f9274960dc6..a4be6f439c47 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1894,7 +1894,6 @@ static int fcoe_device_notification(struct notifier_block *notifier,
 		mutex_unlock(&fcoe_config_mutex);
 		fcoe_ctlr_device_delete(fcoe_ctlr_to_ctlr_dev(ctlr));
 		goto out;
-		break;
 	case NETDEV_FEAT_CHANGE:
 		fcoe_netdev_features_change(lport, netdev);
 		break;
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 83ce4f11a589..45136e3a4efc 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7442,7 +7442,6 @@ static int find_PCI_BAR_index(struct pci_dev *pdev, unsigned long pci_bar_addr)
 				dev_warn(&pdev->dev,
 				       "base address is invalid\n");
 				return -1;
-				break;
 			}
 		}
 		if (offset == pci_bar_addr - PCI_BASE_ADDRESS_0)
diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index 6a2561f26e38..db4c7a7ff4dd 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -758,7 +758,6 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 		scp->result = SAM_STAT_CHECK_CONDITION;
 		memcpy(scp->sense_buffer, &req->sg_list, SCSI_SENSE_BUFFERSIZE);
 		goto skip_resid;
-		break;
 
 	default:
 		scp->result = DRIVER_INVALID << 24 | DID_ABORT << 16;
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index b0aa58d117cc..e451102b9a29 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9487,7 +9487,6 @@ static pci_ers_result_t ipr_pci_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_perm_failure:
 		ipr_pci_perm_failure(pdev);
 		return PCI_ERS_RESULT_DISCONNECT;
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
index 7041e2e3ab48..1b87d9080ebe 100644
--- a/drivers/scsi/isci/phy.c
+++ b/drivers/scsi/isci/phy.c
@@ -753,7 +753,6 @@ enum sci_status sci_phy_event_handler(struct isci_phy *iphy, u32 event_code)
 		default:
 			phy_event_warn(iphy, state, event_code);
 			return SCI_FAILURE;
-			break;
 		}
 		return SCI_SUCCESS;
 	case SCI_PHY_SUB_AWAIT_IAF_UF:
@@ -958,7 +957,6 @@ enum sci_status sci_phy_event_handler(struct isci_phy *iphy, u32 event_code)
 		default:
 			phy_event_warn(iphy, state, event_code);
 			return SCI_FAILURE_INVALID_STATE;
-			break;
 		}
 		return SCI_SUCCESS;
 	default:
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index c9a327b13e5c..325081ac6553 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -3341,7 +3341,6 @@ lpfc_idiag_pcicfg_read(struct file *file, char __user *buf, size_t nbytes,
 		break;
 	case LPFC_PCI_CFG_BROWSE: /* browse all */
 		goto pcicfg_browse;
-		break;
 	default:
 		/* illegal count */
 		len = 0;
@@ -4381,7 +4380,7 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 			}
 		}
 		goto error_out;
-		break;
+
 	case LPFC_IDIAG_CQ:
 		/* MBX complete queue */
 		if (phba->sli4_hba.mbx_cq &&
@@ -4433,7 +4432,7 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 			}
 		}
 		goto error_out;
-		break;
+
 	case LPFC_IDIAG_MQ:
 		/* MBX work queue */
 		if (phba->sli4_hba.mbx_wq &&
@@ -4447,7 +4446,7 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 			goto pass_check;
 		}
 		goto error_out;
-		break;
+
 	case LPFC_IDIAG_WQ:
 		/* ELS work queue */
 		if (phba->sli4_hba.els_wq &&
@@ -4487,9 +4486,8 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 				}
 			}
 		}
-
 		goto error_out;
-		break;
+
 	case LPFC_IDIAG_RQ:
 		/* HDR queue */
 		if (phba->sli4_hba.hdr_rq &&
@@ -4514,10 +4512,8 @@ lpfc_idiag_queacc_write(struct file *file, const char __user *buf,
 			goto pass_check;
 		}
 		goto error_out;
-		break;
 	default:
 		goto error_out;
-		break;
 	}
 
 pass_check:
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index ca25e54bb782..b6090357e8a5 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7196,7 +7196,6 @@ lpfc_init_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 				"1431 Invalid HBA PCI-device group: 0x%x\n",
 				dev_grp);
 		return -ENODEV;
-		break;
 	}
 	return 0;
 }
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 983eeb0e3d07..c3b02dab6e5c 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4284,7 +4284,6 @@ lpfc_scsi_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 				"1418 Invalid HBA PCI-device group: 0x%x\n",
 				dev_grp);
 		return -ENODEV;
-		break;
 	}
 	phba->lpfc_rampdown_queue_depth = lpfc_rampdown_queue_depth;
 	phba->lpfc_scsi_cmd_iocb_cmpl = lpfc_scsi_cmd_iocb_cmpl;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index e158cd77d387..0f18f1ba8a28 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9189,7 +9189,6 @@ lpfc_mbox_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 				"1420 Invalid HBA PCI-device group: 0x%x\n",
 				dev_grp);
 		return -ENODEV;
-		break;
 	}
 	return 0;
 }
@@ -10072,7 +10071,6 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 				"2014 Invalid command 0x%x\n",
 				iocbq->iocb.ulpCommand);
 		return IOCB_ERROR;
-		break;
 	}
 
 	if (iocbq->iocb_flag & LPFC_IO_DIF_PASS)
@@ -10234,7 +10232,6 @@ lpfc_sli_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 				"1419 Invalid HBA PCI-device group: 0x%x\n",
 				dev_grp);
 		return -ENODEV;
-		break;
 	}
 	phba->lpfc_get_iocb_from_iocbq = lpfc_get_iocb_from_iocbq;
 	return 0;
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 0354898d7cac..2f7a52bd653a 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2296,7 +2296,6 @@ static int mvumi_cfg_hw_reg(struct mvumi_hba *mhba)
 		break;
 	default:
 		return -1;
-		break;
 	}
 
 	return 0;
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index bc5a623519e7..bb3b3884f968 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1102,8 +1102,6 @@ static irqreturn_t nspintr(int irq, void *dev_id)
 		nsp_index_write(base, SCSIBUSCTRL, SCSI_ATN | AUTODIRECTION | ACKENB);
 		return IRQ_HANDLED;
 
-		break;
-
 	case PH_RESELECT:
 		//nsp_dbg(NSP_DEBUG_INTR, "phase reselect");
 		// *sync_neg = SYNC_NOT_YET;
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 07afd0d8a8f3..40af7f1524ce 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4030,7 +4030,6 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 
 			set_bit(N2N_LOGIN_NEEDED, &vha->dpc_flags);
 			return;
-			break;
 		case TOPO_FL:
 			ha->current_topology = ISP_CFG_FL;
 			break;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index e2e5356a997d..43f7624508a9 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -2846,7 +2846,6 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 	case MTNOP:
 		DEBC_printk(STp, "No op on tape.\n");
 		return 0;	/* Should do something ? */
-		break;
 	case MTRETEN:
 		cmd[0] = START_STOP;
 		if (STp->immediate) {
diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index a9fe092a4906..255a2d48d421 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -4596,7 +4596,6 @@ static void sym_int_sir(struct sym_hcb *np)
 					scr_to_cpu(np->lastmsg), np->msgout[0]);
 			}
 			goto out_clrack;
-			break;
 		default:
 			goto out_reject;
 		}
-- 
2.18.1

