Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23481EF258
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Nov 2019 01:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfKEA5d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 19:57:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38584 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfKEA5d (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Nov 2019 19:57:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so13954782wmk.3
        for <linux-scsi@vger.kernel.org>; Mon, 04 Nov 2019 16:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xkIhjg3CA8A2xt/zuR/0GAuzj9ASm8NoEhaq/ulyiys=;
        b=JoK0ianL25wyPXHTTv259ACei3owH9LdJ7iQiQ+tu2TBtXLYuKPlKA86Fu+DeNUBM+
         e4kWTu7y55PkSsmihS+lwX1RD3Rf/iNhWfP6a7wZfCgITWe69ylZzsZsgJ69KDE3pQaa
         q/KIF8vPgHo7NINfZIORbF8nKaoSiOUSHqoRO84B4YVV9tFFelXO9C12P9IXH0xcvN38
         +kPjrui8xl22I+RRySXdxLAcVQ6HwD5a4OKV+4yyvXuT5pvU7M87ectc2qjXNlQoz+wr
         pNuiFLGrTuQn8q906PmD6MFXPKSFoz4ZByywCxNyId/6sxXdUwJqUD6CEzR8e0SmaV2y
         OCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xkIhjg3CA8A2xt/zuR/0GAuzj9ASm8NoEhaq/ulyiys=;
        b=Jz0GyyBljVv0xj5U6dSWvN32nUncMukRnerSrUfwRT0VtgQpkwQttaCBJ7jH9BPIkK
         7AzYk2N6PzsBRu4FSEQEgh6lM2CUe3M3zZRcmv5ln0rht00Wtqeq/lqejI6LWi0EErin
         iyUqOm48M0wSpefWUeFLZgqFqUJSvoOz0Wl559WLh5wHpgkrFE5EBg+yyKxnUBIJizxY
         vVvI6n7m0MfhG1vtL3V1SXh0wsMpy+/FuhZ0x2Gkie8/jQeDct0TalNH22pCO/X+HHmF
         OMKvzeSMxMywKgg+BpeB59oYZY3LnK01FMO4K/v7mi4ia4K6J7kKFpwMv7vVwEv98QSj
         TovQ==
X-Gm-Message-State: APjAAAXU4ufS0wYz4+gLXCT2ud+lOC7C0v7q5JmPAHT3N+irmBQXXUzb
        fB/buPPzUuAiebV5MVOhiJ6htD7E/L8=
X-Google-Smtp-Source: APXvYqyB1i+Cv9pRgxffirFV5to3EOe/6nDJ/v6ZDtK1fvzzMajmsFrm1rfxC2xdAh2e80zeNxzmeg==
X-Received: by 2002:a7b:cb83:: with SMTP id m3mr1464236wmi.134.1572915450932;
        Mon, 04 Nov 2019 16:57:30 -0800 (PST)
Received: from pallmd1.broadcom.com ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id g5sm16920991wma.43.2019.11.04.16.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 16:57:30 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 06/11] lpfc: Sync with FC-NVMe-2 SLER change to require Conf with SLER
Date:   Mon,  4 Nov 2019 16:57:03 -0800
Message-Id: <20191105005708.7399-7-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191105005708.7399-1-jsmart2021@gmail.com>
References: <20191105005708.7399-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Prior to the last FC-NVME-2 draft, SLER and CONF were independent.
SLER now requires CONF to be set.

Revise the NVME PRLI checking to look for both inorder to enable SLER.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 64b7aeeea337..3bbe77c36a05 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -2121,7 +2121,9 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		if (bf_get_be32(prli_init, nvpr))
 			ndlp->nlp_type |= NLP_NVME_INITIATOR;
 
-		if (phba->nsler && bf_get_be32(prli_nsler, nvpr))
+		if (phba->nsler && bf_get_be32(prli_nsler, nvpr) &&
+		    bf_get_be32(prli_conf, nvpr))
+
 			ndlp->nlp_nvme_info |= NLP_NVME_NSLER;
 		else
 			ndlp->nlp_nvme_info &= ~NLP_NVME_NSLER;
-- 
2.13.7

