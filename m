Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D28E186
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Aug 2019 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfHNX5r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Aug 2019 19:57:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42025 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbfHNX5q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Aug 2019 19:57:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so412403pgb.9
        for <linux-scsi@vger.kernel.org>; Wed, 14 Aug 2019 16:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBN6Mah2J6SDlUd7s3Wsdy4bqHifGY+4GBh9l8WanyQ=;
        b=GifAKB07Zuwld+eLWazT+iBCQwA60eqxZxv5iCN1NPi4x1y+/wHeJ8NLvZOv+wzYJQ
         Rh3BMVcCo+zwjucxqceRGWjwua9RxrbG5ntK92ncGxB6WKa5Q/ZnuLHharVRdXeIpc+K
         kC/Rd/zhV6sdvLQhkZe2BtkoFn2VjpDn3LHGgNrtxpvLegOxt+mtXvgMqbJJfrJS3xB/
         DoTXwkZS0PIDcdeb8BxuoHS0GOjs8W8qr4huG7DcmkZSan/A/xocmuOe/2c+TEuezcEX
         SXKBlFgYJYr34OvI26N5oEWnwVYAb17hm0D6IWEcxvwkfsaplsqVuijSlc/Kf9WhD9mC
         Sq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBN6Mah2J6SDlUd7s3Wsdy4bqHifGY+4GBh9l8WanyQ=;
        b=fWlVY1VRUT4KTFpj6sTaRKvmGZffk5M9VuwuQvjaBL4gIKDv7fvubwIU5LxakDzknt
         pWRR7S/qVZP938nQBOCP7RuR4+57xbg6fDQi/3o9vV7KzRTb7/l+T4tNizkwNC03yrcr
         WLQ8egGf3hnL5vY0fOU+HdC+Br7NoBRCZeakVmS64OI/a/IyeBQ0pFnJ/GMD6ytpsLsV
         S0v0au1kHHpV9sxLDc4Kd+wcVy7XVeOWxlqbjSwkj4Y0cV2xdvI7Ikb0Q6aYfOt1Nqm3
         lWBCejzDfd5x+NsptROPhYN55yIpMC062JvOAMNc+Fsepo15FPJ6Cbrq9z/H4iiIeLWm
         jSVA==
X-Gm-Message-State: APjAAAUilO5Qk5uvMKPkmdEyUwjFMve5fY4B6wt41UApXYHor7XOrij/
        k/VnF/svcjdbkv4h6+1yK4e1lZ7k
X-Google-Smtp-Source: APXvYqyQMP/TJ3c+sJRtirFlpq8BsYro8Z6CDTW0KLUFTVmSBu7BpRmGKAV8Zta8uhWmxitMsuVSgA==
X-Received: by 2002:a63:1020:: with SMTP id f32mr1414908pgl.203.1565827065571;
        Wed, 14 Aug 2019 16:57:45 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k22sm987299pfk.157.2019.08.14.16.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 16:57:45 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 30/42] lpfc: Fix Max Frame Size value shown in fdmishow output
Date:   Wed, 14 Aug 2019 16:57:00 -0700
Message-Id: <20190814235712.4487-31-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190814235712.4487-1-jsmart2021@gmail.com>
References: <20190814235712.4487-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Max Frame Size value is shown as 34816 in fdmishow from Switch.

The driver uses bbRcvSize in common service param which is obtained
from the READ_SPARM mailbox command. The bbRcvSize field which is
displayed is a three nibble field but the driver is printing a full
four nibbles.

Fix by masking off the upper nibble.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index c52d5edf4d44..1717f3403a97 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2552,7 +2552,7 @@ lpfc_fdmi_port_attr_max_frame(struct lpfc_vport *vport,
 	ae = (struct lpfc_fdmi_attr_entry *)&ad->AttrValue;
 
 	hsp = (struct serv_parm *)&vport->fc_sparam;
-	ae->un.AttrInt = (((uint32_t) hsp->cmn.bbRcvSizeMsb) << 8) |
+	ae->un.AttrInt = (((uint32_t) hsp->cmn.bbRcvSizeMsb & 0x0F) << 8) |
 			  (uint32_t) hsp->cmn.bbRcvSizeLsb;
 	ae->un.AttrInt = cpu_to_be32(ae->un.AttrInt);
 	size = FOURBYTES + sizeof(uint32_t);
-- 
2.13.7

