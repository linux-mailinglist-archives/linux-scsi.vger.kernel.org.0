Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C834554D27
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfFYLFP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:15 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:32977 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfFYLFP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:15 -0400
Received: by mail-pf1-f182.google.com with SMTP id x15so9322742pfq.0
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RL1aRJOLxqXyxOFp2XTkM11O//DXdQuboF4qE6dMT68=;
        b=afEc9cwEHFNMIhN1gOqr1rcLD5CV0Ul9WQKH9S0zIEvHC4EOfl/McV206OSVJ+Eq3W
         2BGoYo9DUiV7YaqUvf9e9E/8zA9o6tGLbqM8uA8LVRtZZi6iOqRJM1tLhAzliiVzIDAs
         RdyDeaekgpPj4fcx5kQfHfF3YYFdeq3h5XcRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RL1aRJOLxqXyxOFp2XTkM11O//DXdQuboF4qE6dMT68=;
        b=fiwrWgXLaubO8RllfhTTCYqNv4z0OfQ9CYkhHxW6lAm9YTO72DdsDwLbVfugudn2dk
         /pGodnrMjS2I0Kw8pao85j/AHtmJKzSFDGu7cywyPg0EnCgYt1A9jALA8xbvBG6ccBdT
         PZC9Il4lzy3k4zGXj9YebQuG8+4YIHFukoIILkC7esFzv3TgzMVJWESrhQ9Of7B4r5Rx
         +iBEYrsbi6V0dPaqW8ydLdd0KDZiy3VAVhLh5Q7DikgzGJsuLUbp7uvYAFCEZ2YXeGSx
         4Dij+9Hv/G2sXjiz534WpeJm9yLMEHlqAoHrd0m96W7ksb/o9Q0mrtbbRCFPNjshic//
         yusA==
X-Gm-Message-State: APjAAAWPJTswMvTNNLRN/YV/x29QiFRtNGINEcaPS38T0tm6vLPsTJxd
        cWE68zDiCpEgibds9/LaNjXhKk6lDo908hpB3uWZ/y11EtP1ydvfaUCVu0ALPc/okfPzG1vMQmw
        GnzPifaEtuXXW0JYYdXI8rx9W1g/VAGoaKdgqAjEl73WJLRiKPrbV4p5QBmr6VJcIPu2cZLKZC9
        IOD3VKxyk6BRT5
X-Google-Smtp-Source: APXvYqxONfLqD+4eiOvp/pDPGsg1BsRriXMNogj1R8TluQ0wF+G21+w56OzBxrLDH7S5EPQpdBOIVg==
X-Received: by 2002:a17:90a:2627:: with SMTP id l36mr32026539pje.71.1561460714130;
        Tue, 25 Jun 2019 04:05:14 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.05.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:13 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 07/18] megaraid_sas: Don't send FPIO to RL Bypass queue
Date:   Tue, 25 Jun 2019 16:34:25 +0530
Message-Id: <20190625110436.4703-8-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Firmware does not expect FastPath IO sent through Region Lock Bypass queue.
Though firmware never exposes such settings when fastpath IO can be sent
to RL bypass queue but it's safer to remove dead code which directs
fastpath IO to RL Bypass queue.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 2e711b1..a765662 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2876,10 +2876,6 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 			(MPI2_REQ_DESCRIPT_FLAGS_FP_IO
 			 << MEGASAS_REQ_DESCRIPT_FLAGS_TYPE_SHIFT);
 		if (instance->adapter_type == INVADER_SERIES) {
-			if (rctx->reg_lock_flags == REGION_TYPE_UNUSED)
-				cmd->request_desc->SCSIIO.RequestFlags =
-					(MEGASAS_REQ_DESCRIPT_FLAGS_NO_LOCK <<
-					MEGASAS_REQ_DESCRIPT_FLAGS_TYPE_SHIFT);
 			rctx->type = MPI2_TYPE_CUDA;
 			rctx->nseg = 0x1;
 			io_request->IoFlags |= cpu_to_le16(MPI25_SAS_DEVICE0_FLAGS_ENABLED_FAST_PATH);
-- 
2.9.5

