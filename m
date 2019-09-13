Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E37B1E20
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Sep 2019 15:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfIMNFK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Sep 2019 09:05:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35464 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfIMNFK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Sep 2019 09:05:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so18053033pfw.2
        for <linux-scsi@vger.kernel.org>; Fri, 13 Sep 2019 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CRkb4M6GPrEjWRWFRgB6VomGtlcUoHIQDhVlL7C0iJA=;
        b=cxzo3ib9DZu91rUuFP6TsWXwGXEKxY4Ha+vkwb1nSqdcp7sQbEYv7z5n7l/F16x1rs
         LcgnwpEhAd/Gf15yHGoQpND3px6NfncJhhbO4clS3A6xqT9WqySm4SfvYyUN6Q38Jv0k
         paV/Oh7zLfWmA9JsJocI5xhoSYQp3kVQIv3PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CRkb4M6GPrEjWRWFRgB6VomGtlcUoHIQDhVlL7C0iJA=;
        b=Jmkdg+oJZWmDZVNLOiIUTJDSit8f2jFKD3hvY8fot8CdBNh17p5FhBBllC4rZsxQpu
         //5mKBZgW+Vp5WBcTQdFF0OG0uEx2de2EH8zi720x5aJX3rFVFEudJ79AKuldqXQpMIA
         Bte0wTZxOBiudJPkUTdIBamjbd1B/4/PcWB4utjZjbLl8z/Qvp1hhKgcQHaY+7Ez1wnJ
         8Su7Vzt4bTd8Rst8FYA0+7I4ectQBpMGDnfPimjyMoRIHLbpyTTZ3NTRRKI1W6pT3ipo
         OqCsxWMaSHC+GAmtPr4ORra8IqCOtvofSVWWJ5AaVylsaBLy2oeICNXzQXGqHjiBXOTB
         8xlA==
X-Gm-Message-State: APjAAAWMDqkDT5mShp3OGC+VzYZmAeJ8DXJ0UDjbeJ20AU+JawCFPWb2
        AtTOO141YsI6+zkMx73kSt/v+w==
X-Google-Smtp-Source: APXvYqw/hnsnE/GBTVjw1QyVjGdnM0M3IOJV/nPqUWyVl7j/QleBfLscDgs3iI4dWyuhkbgOWHHvtQ==
X-Received: by 2002:a17:90a:804c:: with SMTP id e12mr4831309pjw.3.1568379910011;
        Fri, 13 Sep 2019 06:05:10 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 69sm37208841pfb.145.2019.09.13.06.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 06:05:09 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, suganath-prabu.subramani@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 04/13] mpt3sas: Free diag buffer without any status check
Date:   Fri, 13 Sep 2019 09:04:41 -0400
Message-Id: <1568379890-18347-5-git-send-email-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568379890-18347-1-git-send-email-sreekanth.reddy@broadcom.com>
References: <1568379890-18347-1-git-send-email-sreekanth.reddy@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Issue:
Memory leak can happen when diag buffer is released but not
unregistered(where buffer is deallocated) by the user.
since during module unload time driver is not deallocating
the buffer if the buffer is in released state.

Fix:
Deallocate the diag buffer during module unload time without
any diag buffer status checks.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index a195cae..9b37a32 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -3773,12 +3773,6 @@ mpt3sas_ctl_exit(ushort hbas_to_enumerate)
 		for (i = 0; i < MPI2_DIAG_BUF_TYPE_COUNT; i++) {
 			if (!ioc->diag_buffer[i])
 				continue;
-			if (!(ioc->diag_buffer_status[i] &
-			    MPT3_DIAG_BUFFER_IS_REGISTERED))
-				continue;
-			if ((ioc->diag_buffer_status[i] &
-			    MPT3_DIAG_BUFFER_IS_RELEASED))
-				continue;
 			dma_free_coherent(&ioc->pdev->dev,
 					  ioc->diag_buffer_sz[i],
 					  ioc->diag_buffer[i],
-- 
1.8.3.1

