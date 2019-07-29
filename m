Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA827836C
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 04:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfG2Cyz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Jul 2019 22:54:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42008 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfG2Cyy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 28 Jul 2019 22:54:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so27195837pff.9;
        Sun, 28 Jul 2019 19:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ULGnzYJXZaJE7MAKvACKGRFG44YFo4oofMSCNLQo9x0=;
        b=rpzzYJCDah/qwpKl6PxReqg+Kn7i0regxqwMVdhNBBC4W1g3goPhN3MPyviApdhSSd
         bJ4L5KNVop6mqeyZv9ZphD8SjWMrlTJI3OQ9wH0oq/G6KhASHMJKK82LmAHJCVMOjDij
         5mweyGgMAlXPIAzjeh+/MWWxT798tfAmR2eue6v5LxRlnPm97uzdtCe30gsCGjXw3dgo
         6xKMb+O/GPzRhmsycV19N+ogd+aWG7XTOCt1L88zku+gLSBuqLNK/eUFxNzdfLMhCdKa
         3HTmBglBwcYceBE/LSdqGQigGNWnI54DOOlTpWKPk+nQpGUh4VhFKSwq7dvbg7/Sxn3C
         wKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ULGnzYJXZaJE7MAKvACKGRFG44YFo4oofMSCNLQo9x0=;
        b=UaKjQRESncpiDYDMUHesvCxLjuLVcPqd+eFL6CRwbfB1hM7FCjnICo6k34Qnfisfhi
         BrpMW/ugevDrl+rBcIMuiOTDmFrsfxdSG5+jPAWAJfTJL7Xm1lbgKZdt4hhoDxI7BswP
         o/z3c1ciKK1fKhEfTgmXQgqJRKEfFIxtNfdRSyljcKYd+dHA+y1e922favdPfd1Nl1Vg
         pGc/gCvtx2cGCj2iUwyrYR402DrxlUqYqcCmLNexgt+HCuIZDyR/gmM2/algSEme2+8O
         1gJOum5HOWBJlTG4GWiNgPiIqdRI2QgPImGJZ3xfQy5MEQXf4N96PXrHCzz0Pw3q7oJU
         51Hg==
X-Gm-Message-State: APjAAAXJR1H4oi3S97MMN0/TzEzqfupT+g+Hdd0TCSak79n4af2vV+EO
        kSrL2cDhwZoe5jRi6dTbA02VZEjo
X-Google-Smtp-Source: APXvYqyZ2efTdk6a2sgndgeD3VPyZ5NbmxlxLpmgCiNY8sJefJKAZzV5kAV8xLBCw8+dvfmMWlTMJg==
X-Received: by 2002:a17:90b:d8f:: with SMTP id bg15mr109236464pjb.65.1564368894245;
        Sun, 28 Jul 2019 19:54:54 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id 131sm73963621pfx.57.2019.07.28.19.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 19:54:53 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: megaraid: Fix possible null-pointer dereferences in megasas_complete_cmd()
Date:   Mon, 29 Jul 2019 10:54:45 +0800
Message-Id: <20190729025445.18312-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In megasas_complete_cmd(), there is an if statement on line 3411 to
check whether cmd->scmd is NULL:
    if (cmd->scmd)

When cmd->scmd is NULL, it is used at some places, such as on line 3286:
    cmd->scmd->result = alt_status << 16;
on line 3295:
    cmd->scmd->scsi_done(cmd->scmd);
on line 3343:
    cmd->scmd->scsi_done(cmd->scmd);

Thus, possible null-pointer dereferences may occur.

To fix these bugs, cmd->scmd is checked before being used.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b2339d04a700..181c4d9cd707 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3440,6 +3440,9 @@ megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
 	case MFI_CMD_LD_READ:
 	case MFI_CMD_LD_WRITE:
 
+		if (!cmd->scmd)
+			break;
+
 		if (alt_status) {
 			cmd->scmd->result = alt_status << 16;
 			exception = 1;
-- 
2.17.0

