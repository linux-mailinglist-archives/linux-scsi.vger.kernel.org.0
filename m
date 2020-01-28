Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE71B14AD2B
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Jan 2020 01:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgA1AXq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 Jan 2020 19:23:46 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37631 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA1AXq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 Jan 2020 19:23:46 -0500
Received: by mail-wr1-f42.google.com with SMTP id w15so13981888wru.4
        for <linux-scsi@vger.kernel.org>; Mon, 27 Jan 2020 16:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K87LHaQz1yrRwgYzzZFb4Qqz7l8/12sOLki2Sx4blD4=;
        b=Bka2+OnLHjRImDX17da680stz2qwIlla8mGRavHCmpwYy9vrvTJMObg7PyMbohpjgl
         GHpZRfhyjbonY7oM9/A4atxXpGSOwVZsX4n8hdQV5cEXHoJIoJJFsV7lzJjToEauubRg
         xTxW4dAOnfZWIqlQAuSgcswBTJ/TZO/Ix3uX+F/thy9VoTcxP/2n8ZgVnqFDbNEifupT
         LiSqI5vs+qNc6OH+kYvNRZRLKEZH2j1Idx67loJ3rs+7WVPG3upZgihsvDqlFRKfD7CH
         +vhqqKK7JjLdiTgar5PJl6ZKSnBh3nUuRaZGwiLoAIkYcM1MesKu7sgkm5ziVGpokO3c
         S8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K87LHaQz1yrRwgYzzZFb4Qqz7l8/12sOLki2Sx4blD4=;
        b=sHgGISJ9FXXFguY7Vm3EWeOarPjKzjsBtnfzqETpoRLqs8NJ1h/zXscZOqRBISARXp
         DvyBDubjCK5L649inbkFO7Kl3paJhuNMPX4b/mu/rydrfoS8eNIPnOqLOmGiQqzE/vvZ
         eK8Qt/kwdp3TfNjbiob+pbe1H7Id4yEq37PK/kg8lQG/QQSuextTFVCdsDDoGqaiFUDe
         d5K2wKdOoMYXE8wW7HtdPeN076UKxiqEJ+NFyPf/oTlq2igbBzVtSrdWZHMZ6lCy3r6/
         67JTipNFF1NiYkscrG+gCn8lkZZaMybJ0kCx9H9jPqxctI4HoCz0JPYZAZutYpT/uTaU
         i02A==
X-Gm-Message-State: APjAAAXwYvmSw+21phHeB/Sr/lYL6BUUpf3+D4ZnzcCgdzmb2cMNdjUM
        fMtlR31cveCv5X9FKh20/vs/xbWg
X-Google-Smtp-Source: APXvYqyjJZ5gezIE+/5aqrsAZ3EQDlabMxG4DvGOLQRL5wi1gLhgSAO+W2wZzxGAE1wlN2CrTXebow==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr23887369wrc.69.1580171023646;
        Mon, 27 Jan 2020 16:23:43 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z19sm583769wmi.43.2020.01.27.16.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jan 2020 16:23:43 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 11/12] lpfc: Update lpfc version to 12.6.0.4
Date:   Mon, 27 Jan 2020 16:23:11 -0800
Message-Id: <20200128002312.16346-12-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200128002312.16346-1-jsmart2021@gmail.com>
References: <20200128002312.16346-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update lpfc version to 12.6.0.4

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index 9563c49f36ab..25193146ef20 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "12.6.0.3"
+#define LPFC_DRIVER_VERSION "12.6.0.4"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.13.7

