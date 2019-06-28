Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376D0597EC
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Jun 2019 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfF1JvY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 05:51:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43821 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF1JvY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jun 2019 05:51:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so2945100plb.10
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jun 2019 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iEe+w5Cw7Mj27LFlss4tg4ixW0DJ3Q671c2PpFiw87E=;
        b=ThVFYzzaZ+9mY8v6q9AHzWfSogfzdl3H2gVvL5gtP+LkAyoe+h4EbmhAHg0K99fN7r
         Qj7LecniTPlO387P9wT5J7BgeqeD38AnVOJIillUrA2M5ytHPEIx3jAz3eqCbtLzYyij
         xtM68aKJ10113zo8/VYEj5aypr5O7aQzvX/fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iEe+w5Cw7Mj27LFlss4tg4ixW0DJ3Q671c2PpFiw87E=;
        b=YErQUXvwYlSgHzOT3Nfw8rNlwD5aHg6dfT0uEJR+vwISr20+OyrKMQdq1EUkMRz/FR
         8FM93vAy2IMEdA0z7TinDRqn3pKl0zmfEKwEWdvdBfUuXnva9tfjlw75Su4syyIrcXmG
         k3GeQ6hTjAIMDOeLRDq1NTIsaggNj5wNSJ6HOEQ3h7sWZz4fp30OJzoJZAxztQ3DUdoR
         jNAhkv78JXDSmHkJAnsIzEhwYLjs6yuE8FplE2RzpzKAwx19Yg4qzBPXjK4xjQCb+i2J
         kk7mQ8Xt2F8wThksnu2+Wd/vVZ9uKzHNHgrLRzGsNF/9Uunu2XL4cuVNirugiP86ObQv
         RW8Q==
X-Gm-Message-State: APjAAAXPX/pCBF26J7VS2U8UkZ8SpoS3mAbFT5kO19S1V1BeyKIA/Z+K
        3lkKL1XV7Pqm3O8Iavj3tJz7xLkKuW4eqqGWCbnNHvMs7FQuZHxB3Dlex5pftH7WVegczXQIJNR
        XGDPzdFuro2dcVfLnUmUwyuHbc1YxBht0s4nfTMaqoILCvNjmrS9/XqZyEJhT9JzEpk6aPern7L
        GyA+3NbCf0i/MOGy3KxZl7cGo=
X-Google-Smtp-Source: APXvYqzjfeHUp4huZALan4bLaIp6YLtROFU0RAXH9kWOEQDTDnn/EpzvhQkkxUGxJ9CLC6hARN+vNQ==
X-Received: by 2002:a17:902:2ae8:: with SMTP id j95mr9613213plb.276.1561715482920;
        Fri, 28 Jun 2019 02:51:22 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q19sm2096975pfc.62.2019.06.28.02.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:51:22 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, chandrakanth.patil@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 2/4] megaraid_sas: Enable msix_load_balance for Invader and later controllers
Date:   Fri, 28 Jun 2019 02:50:39 -0700
Message-Id: <1561715441-1428-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1561715441-1428-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Load balancing IO completions across all available MSI-X vectors should be
enabled for Invader and later generation controllers only.
This needs to be disabled for older controllers.
Add an adapter type check before setting msix_load_balance flag.

Fixes: 1d15d9098ad1 ("scsi: megaraid_sas: Load balance completions across all MSI-X")
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 9321878..96b6510 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5945,7 +5945,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 					instance->is_rdpq = (scratch_pad_1 & MR_RDPQ_MODE_OFFSET) ?
 								1 : 0;
 
-				if (!instance->msix_combined) {
+				if (instance->adapter_type >= INVADER_SERIES &&
+				    !instance->msix_combined) {
 					instance->msix_load_balance = true;
 					instance->smp_affinity_enable = false;
 				}
-- 
2.9.5

