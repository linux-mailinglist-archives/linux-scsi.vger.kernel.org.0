Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8146E2A3BF
	for <lists+linux-scsi@lfdr.de>; Sat, 25 May 2019 11:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfEYJmO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 25 May 2019 05:42:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46926 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfEYJmO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 25 May 2019 05:42:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so1902816pfm.13;
        Sat, 25 May 2019 02:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QUf7j2G4TR/XOjAVHKTk85Pmwvoby3ulkAqwU+DbaeM=;
        b=REliOAXhJoRKu38PvPanSiAGUDtQmN8dOojq6O2bxDriGcZWhamrlztq9Pe9Dni+KU
         g9HXu8RBPi+lHPuNKZk9XSimyK+iRDAxG1wFrZmnEMT+mPiHEe2HEDDT8vXiI+zLn+bY
         hqddB9ZRkBpt79BiGvOtuA3GThoCqOZBga5n62TiXsOYxjCrV9W+efsvegDy4iYQ68Cz
         j4vtf/mqN3DuosjzWjNsnv+rzZYAKZibfTu2Dx653dBzmGme42yvIOUKdRDPn2wSRDXN
         1UPi47lI/gRbLr/xQEvzsXWESPPecx4SvXkrbWtIJp2TKmBzXAx5Msk5tbaOUg8jWZf/
         r0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QUf7j2G4TR/XOjAVHKTk85Pmwvoby3ulkAqwU+DbaeM=;
        b=GY26m7XHnWzAIV+8xgmYjcB6Ki6zUs+FaGh2j1mUhccSi4mO6O22aKfjCYuGqydy49
         9UiX27LVdLcIXTHrx+MQUPnoMIf8HsPM0RMigndzLQXFig/DsD60B4xJ9Jp6sb+dXiDL
         0t7QRkIZ8Sl/QNdNAPisXpOYTjaKKfJLqRVXQJso87CQwS44DV7G6Rxhssor13Yz+sbl
         DpxifIK00hPccxcRbkC+HmyJttCRz6D5nYQ8GSjY1f13mg4tuukBNRr/42O/cAsEpv59
         vkd2EvP8NR5KbmR4qkn8RyHNfr5FIMxfwxtspvSOqXp1AEKWn6Fiyc/e7s3l0XtQoPpF
         Ho7g==
X-Gm-Message-State: APjAAAXFX2766WAN1i/udmmuCe/g8sW/uWzoyL62XKFRsvILJlct+mH7
        mOfb7d0hAUjLFB0clB3ePdo=
X-Google-Smtp-Source: APXvYqx0qU3Oa0qVLD0K2C5JaSg+X6lxw0UuD0FGIt2stXOPHViN9YGmaYJA5afBNf4Wxav/hy6nIg==
X-Received: by 2002:a63:8449:: with SMTP id k70mr109311997pgd.53.1558777333777;
        Sat, 25 May 2019 02:42:13 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id r3sm5186846pgn.12.2019.05.25.02.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 02:42:13 -0700 (PDT)
Date:   Sat, 25 May 2019 15:12:05 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Wei Li <liwei213@huawei.com>,
        Geng Jianfeng <gengjianfeng@hisilicon.com>,
        Zang Leigang <zangleigang@hisilicon.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kangjie Lu <kjlu@umn.edu>, Arnd Bergmann <arnd@arndb.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/scsi: fix warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190525094205.GA21778@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fix below warnig reported by coccicheck

/drivers/scsi/ufs/ufs-hisi.c:459:1-3: WARNING: PTR_ERR_OR_ZERO can be
used
./drivers/scsi/qla2xxx/tcm_qla2xxx.c:1477:1-3: WARNING: PTR_ERR_OR_ZERO
can be used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 4 +---
 drivers/scsi/ufs/ufs-hisi.c        | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index ec9f199..4357b34 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -1474,10 +1474,8 @@ static int tcm_qla2xxx_check_initiator_node_acl(
 				       sizeof(struct qla_tgt_cmd),
 				       TARGET_PROT_ALL, port_name,
 				       qlat_sess, tcm_qla2xxx_session_cb);
-	if (IS_ERR(se_sess))
-		return PTR_ERR(se_sess);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(se_sess);
 }
 
 static void tcm_qla2xxx_update_sess(struct fc_port *sess, port_id_t s_id,
diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 7aed0a1..f506044 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -456,10 +456,8 @@ static int ufs_hisi_get_resource(struct ufs_hisi_host *host)
 	/* get resource of ufs sys ctrl */
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	host->ufs_sys_ctrl = devm_ioremap_resource(dev, mem_res);
-	if (IS_ERR(host->ufs_sys_ctrl))
-		return PTR_ERR(host->ufs_sys_ctrl);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(host->ufs_sys_ctrl);
 }
 
 static void ufs_hisi_set_pm_lvl(struct ufs_hba *hba)
-- 
2.7.4

