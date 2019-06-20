Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B24CC58
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfFTKxI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43992 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfFTKxI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so1443713pfg.10
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMzim16g0haLFiQPV9XYI5J3leuIdfSlox5jPaNCXRY=;
        b=dmstti4MBadGKh5tMU3ya5j83KDtpg0aiqYHKmkw2oUvuo0nezHf7pceBPLWB9GCsA
         NQ1+TgIyWIGaMmtoxJU8Kb6Rc0WS4b/I49h+VcFB39ZGOMV2YVJHdtI1Xb+D8RWDhzQR
         YsyL3yCSCe/+I1hUFjgQhvDbqCYH4ZzNDVL54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CMzim16g0haLFiQPV9XYI5J3leuIdfSlox5jPaNCXRY=;
        b=lP+rvmwcW+4boG39LhqaIPb2W+gjahzdjjmt0B1rg1eluZ7mlTqnvrGrvAPq+zCUqh
         jDlrlg1Srr/kOeOWNCnr+saV17zAwRQhcZ7+1CHY98heRG2m6NLsKwoLCF67tw7rUU/U
         /n9nNtrDgJjxvdaDxfsDDXbzYUl3+JfIVMo+r4lizKgEMhcxN3B2QnkEzHsx8lgSYWXG
         lwzHdkb1finSqPqOCBZ3w+MGfVQkNFV4lOc2uR71W0bgPpOrEBQ7iIqwZXzcs4+/7mjd
         gYXVm5TU1jkT3UyhIwxXIzg8443TeZP6Uo7946U9q/+Nmx/skK+ko+LqSACkByrKfiZf
         srJg==
X-Gm-Message-State: APjAAAXJgCva6yFY1gFM88+SLzBa0TRKFc+ux7u1LdPmRllAiGeJzlUP
        iPGEO+VZ1tvRe0jHZixytrHJyzxHRWx9GVlW44SwKMVxeY6vfeJGrNG4S5r2CmPGRt7z/QRWMHW
        aJ4GrniINxLbpdOlmtK0qQUPI4Q1pxmY7vKhRuny+UyR//8qLCHKOPOK26Y0IHMGochPzj6PivF
        ZJPQVz2Om5JKoeqUI=
X-Google-Smtp-Source: APXvYqxQi2l8BREl0irCvPEt38PHCbyDJ3W311mGfWoQZ7BnmmeCeZeTQGPoZtw+V7fF1yAXOvt89Q==
X-Received: by 2002:a17:90a:2343:: with SMTP id f61mr2486229pje.130.1561027987347;
        Thu, 20 Jun 2019 03:53:07 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.53.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:06 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 09/18] megaraid_sas: megaraid_sas: Add check for count returned by HOST_DEVICE_LIST DCMD
Date:   Thu, 20 Jun 2019 16:21:59 +0530
Message-Id: <20190620105208.15011-10-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 554ec72..a886de3e3 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4827,6 +4827,9 @@ megasas_host_device_list_query(struct megasas_instance *instance,
 		 */
 		count = le32_to_cpu(ci->count);
 
+		if (count > (MEGASAS_MAX_PD + MAX_LOGICAL_DRIVES_EXT))
+			break;
+
 		if (megasas_dbg_lvl & LD_PD_DEBUG)
 			dev_info(&instance->pdev->dev, "%s, Device count: 0x%x\n",
 				 __func__, count);
-- 
2.9.5

