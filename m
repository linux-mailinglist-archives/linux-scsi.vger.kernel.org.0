Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B14CC55
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbfFTKxC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:53:02 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:44377 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKxC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:53:02 -0400
Received: by mail-pg1-f176.google.com with SMTP id n2so1373148pgp.11
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RL1aRJOLxqXyxOFp2XTkM11O//DXdQuboF4qE6dMT68=;
        b=AkfCEtGjdNCuJ9ExPiODDUwg+sjMG2yAGcBflrydJaEvC4JpNbjOR4HQ+IAhcV1Of4
         vUHetJjL+lapT9hQuRpNljUrGsShQ8eMJjxHX9pnxAFLqUOOkQpEjSbDcyVIeyZuG6xp
         u3NTqOK6uzXR1db6tt04hjhGc92MdYftTezvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RL1aRJOLxqXyxOFp2XTkM11O//DXdQuboF4qE6dMT68=;
        b=bnA/OaL6mOog3A5/mCLrH+dZHLGSjfPChIUk7Y1nv15jFCzcdem6kV39eBFTojX24+
         ZK4ZIkw+/yC0ayaaAsgOTxHRZJbmVr+c0VHMnvuLVc6rtKlRucGk3wdcs78ToLtYMW0W
         7QpD8LEnuNPZ1/Zj8zip0i6ZZBOc9f9BnWdhyCM8fNbQIT2x7AAU1yWyAbch6HVkWHOO
         NtyvxE0BTioR+Rkmb/yEIlGnX9TSvmTuQjGsNfUP2ifD/6QOdIb+8yABqZW6CVf86w6C
         3+Q+vuh8+HvOKSUph4i8PSXtVcz96zsRy7GSF+D07H0WtlNzpeD2PAh6Y45zhfcjlUBA
         eDkA==
X-Gm-Message-State: APjAAAXBl4LJqh6nrbn8mnJTSzSPlF5eK86izseSGvovX95AB8B7C0xF
        fH1a1Bfrfv07mDK4gRS6GleVN00YGi9LXKYWgUy4kjiM/v6CDZJ1JQHNLQ/FiBB1log7x+YOvpE
        Grp2k4yEdQy2MeE1+ir5u2IGcdZyh/3U8kGSkwkfw0bkTjstiJS0KoNB+mckbFqR4jhhug9J/Dx
        wWBea7DIVPFzBS2pQ=
X-Google-Smtp-Source: APXvYqwPQy/ZyBhRoW9Yt+rcnSCJufkxqdsDrN8NTyQx0q16KkH8GMRjBbsayKa3JZkdOM3e9yBw9g==
X-Received: by 2002:a17:90a:480a:: with SMTP id a10mr2464867pjh.57.1561027981140;
        Thu, 20 Jun 2019 03:53:01 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.52.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:53:00 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 07/18] megaraid_sas: Don't send FPIO to RL Bypass queue
Date:   Thu, 20 Jun 2019 16:21:57 +0530
Message-Id: <20190620105208.15011-8-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

