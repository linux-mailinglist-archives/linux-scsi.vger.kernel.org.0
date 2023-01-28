Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4330467F297
	for <lists+linux-scsi@lfdr.de>; Sat, 28 Jan 2023 01:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjA1AEU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Jan 2023 19:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjA1AES (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 27 Jan 2023 19:04:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4384FA5
        for <linux-scsi@vger.kernel.org>; Fri, 27 Jan 2023 16:04:16 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e10so4217856pgc.9
        for <linux-scsi@vger.kernel.org>; Fri, 27 Jan 2023 16:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDc1f6H36kSbMyhmdOu12h8TguEbHWVRiGzB2+CN2EQ=;
        b=jqN19sWZ3nZ1ylcOToqEKpzql3r9UmN8+byIOuXDFEh2VxNe/47KCoXcmXX2cCO8t0
         artbB2vnijdLeMOclOlwjOQ4oil+/MxPYfFhyebOQLChNRaruqY1qpqQ2eFTJSg5TdAu
         i1uFKylpcNV6TRc0ZpzXNmOK0MT8gRs3RUt/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDc1f6H36kSbMyhmdOu12h8TguEbHWVRiGzB2+CN2EQ=;
        b=r9fKj08lxfjO57ukiOTxphNQrA+DllifFi5jvZ/8qz2lDMyU5E+q/J/nTq+at8LUAV
         TRgbhxZ2lWfENxH31n1QJ6uDSF6p2HQLfzTX0wN0kEjaQljUtH/04N14zXIoVL28QfWw
         m4U2ZCi7RAOJ4GYGhPXhigbm17hc1hS2HI+4OxWIS1jwnNXTRBjdlFRWEMRy6r+SlCqh
         qD5BOsh1SJ0vmIiIUL77rCMlCxB86W26x7eKuw3ycuHxC15gKCSyw1cOReZhcd0QRxuV
         J4HguHipiCZgHn9HN/5gJYuwpaajH3YUAkE4N7cFcvRtRTgTeu2AEM5k6LxT0CuRJlCK
         loSg==
X-Gm-Message-State: AO0yUKVXKgowEBP2EvipMgjgfRE16XViyTTpEWeh3mK/APixb7ggSj3n
        IAcIVEyGaaSPvPsLjcB+wRgqbw==
X-Google-Smtp-Source: AK7set8nSePnnSfEVdKbfxF6scz0/Uj2c71pQ6W+5fNQ70sm53fXibm/RGvGyWY1TXB5PRKOwLAytQ==
X-Received: by 2002:a62:b505:0:b0:593:9109:4627 with SMTP id y5-20020a62b505000000b0059391094627mr714429pfe.0.1674864256051;
        Fri, 27 Jan 2023 16:04:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x28-20020aa7957c000000b0056bc5ad4862sm2527886pfq.28.2023.01.27.16.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:04:15 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Kees Cook <keescook@chromium.org>, Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: aacraid: Allocate cmd_priv with scsicmd
Date:   Fri, 27 Jan 2023 16:04:13 -0800
Message-Id: <20230128000409.never.976-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826; h=from:subject:message-id; bh=8KFZgqjwwJO+qq8QfdeM9HK9KDv6PDJJEB0n/EnuyKA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1GZ9mcYxxmBFWjb9WJlVcSCr1yuma3vzlXTE6ry5 XFz/f5+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RmfQAKCRCJcvTf3G3AJnDqD/ 47sfkHG+/a3xdJClnia5fi++tP4YYoZynZ5fqtTBOFFNLI319Zlz2wlqHjfcc1sz2eweq62ksWB2TB YW6aC0dSd+5FoXkT4uVVml2nZDZxy0E9cMn2qJ5pFbZrfCZpmSrashWSunKUeB6Eb4TfkgLG61WIFP SNYnzVIz4DVO/INJgJobsjQyp4axpBZCRpmBiw14V4sIv3fDg+OWXVTqUNHFMm1DULBEPAVxaBx+FQ Vti5fflR3WJMRI7HCoNdsO+iRnZ+FyCybX4oNoYu2SVas+pzDJfwP+NUWc/j5M0ALVZTshiuQBol6U c+3T6d0A/LN3kWyICneQSULVNfMLPw8hcgAZHl9v3tWN5l2O40zGRqliaTZDJ31k+Tfc3vtTzp1aVy N1rAU9Q6dCDJgAPqm8cu6SCUFyQawV5xfY9S0qh4M0kGY0kPaAreBvLizpLSd6rWgB/5eIY+1Lluu2 tEKhMvRr0BQTUtBNKtPxtZYjJtBFAjetGQ8g3ez42Ty0CZ0nONtVCkcAi1PsysjehWBTlTrau8Zr2i /tSBvd730+TfBbfhB3sZcDKpuWL6mL59ZKPRX+8as6QZklDgblu72PXEY+nA4K6uArXk0P9m50S1wY 3qo8bUnPG18px6gVheiFE0q7XMDZ9RHj+yhfnrvE8zSygQh2akGwWKFqbieQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The aac_priv() helper assumes that the private cmd area immediately
follows struct scsi_cmnd. Allocate this space as part of scsicmd,
else there is a risk of heap overflow. Seen with GCC 13:

../drivers/scsi/aacraid/aachba.c: In function 'aac_probe_container':
../drivers/scsi/aacraid/aachba.c:841:26: warning: array subscript 16 is outside array bounds of 'void[392]' [-Warray-bounds=]
  841 |         status = cmd_priv->status;
      |                          ^~
In file included from ../include/linux/resource_ext.h:11,
                 from ../include/linux/pci.h:40,
                 from ../drivers/scsi/aacraid/aachba.c:22:
In function 'kmalloc',
    inlined from 'kzalloc' at ../include/linux/slab.h:720:9,
    inlined from 'aac_probe_container' at ../drivers/scsi/aacraid/aachba.c:821:30:
../include/linux/slab.h:580:24: note: at offset 392 into object of size 392 allocated by 'kmalloc_trace'
  580 |                 return kmalloc_trace(
      |                        ^~~~~~~~~~~~~~
  581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  582 |                                 flags, size);
      |                                 ~~~~~~~~~~~~

Fixes: 76a3451b64c6 ("scsi: aacraid: Move the SCSI pointer to private command data")
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/aacraid/aachba.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 4d4cb47b3846..24c049eff157 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -818,8 +818,8 @@ static void aac_probe_container_scsi_done(struct scsi_cmnd *scsi_cmnd)
 
 int aac_probe_container(struct aac_dev *dev, int cid)
 {
-	struct scsi_cmnd *scsicmd = kzalloc(sizeof(*scsicmd), GFP_KERNEL);
-	struct aac_cmd_priv *cmd_priv = aac_priv(scsicmd);
+	struct aac_cmd_priv *cmd_priv;
+	struct scsi_cmnd *scsicmd = kzalloc(sizeof(*scsicmd) + sizeof(*cmd_priv), GFP_KERNEL);
 	struct scsi_device *scsidev = kzalloc(sizeof(*scsidev), GFP_KERNEL);
 	int status;
 
@@ -838,6 +838,7 @@ int aac_probe_container(struct aac_dev *dev, int cid)
 		while (scsicmd->device == scsidev)
 			schedule();
 	kfree(scsidev);
+	cmd_priv = aac_priv(scsicmd);
 	status = cmd_priv->status;
 	kfree(scsicmd);
 	return status;
-- 
2.34.1

