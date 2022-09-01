Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BA25AA11A
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Sep 2022 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiIAU5g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Sep 2022 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiIAU5e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Sep 2022 16:57:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83C80EA2
        for <linux-scsi@vger.kernel.org>; Thu,  1 Sep 2022 13:57:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d12so18178099plr.6
        for <linux-scsi@vger.kernel.org>; Thu, 01 Sep 2022 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6bNaco3dz7IXQ11OXE5kaxXCKtEGcZVScgtt1VLo0BY=;
        b=lz9bmAcSmJgqr7GHx+GhotVgFEl7+NLMUFsxU/Z8181ZKalwXzq956AcPOKxCTD6fS
         5EyA5gCbMzEjufG7GCMLoVPUiKr6r3Ua1lDVdOrMmzUG6PjXUgoSqajP6vOAef2Ssjww
         VXIx89M/XqRQw5ntFMdvGg93Oj8t/Z/2Ubc8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6bNaco3dz7IXQ11OXE5kaxXCKtEGcZVScgtt1VLo0BY=;
        b=fESsDqOb2Cnjhyu0rJMqgk0vxjce7JV6zYxpmkUlc57FMMk3a+BHhxSdyFoPFCGY5o
         9+HJkp6GNPWCLnIf9ySF87ytNrhAaJ+BdwAhEGRli3bZMxzOdrOnS3u6otpkDQDZOyHb
         Y0uK23DQXBSkyKJ8RoGlRL9yloF4wkyex7BIetUKlwOOG2OOM8Id1qYcwpU7BtaI969l
         rRIQF1ZkNwMml/LqSxrXV7d5xAomUqU/OQvDo3damo+d+z/vmum9YM2yzbGGg5M5t1IX
         zHcj49yCmd1dU7r7Pe1rNpJqnTxAHoGhDl3NzbD9xnN59dFGa83WJiextR2yS/OpgWbt
         vG9w==
X-Gm-Message-State: ACgBeo2IDTcfxr85tbPeVBukWPDbdS/KkBq5GEFYlIUWA4RjtwxIvxYI
        FYaNeiIOwI66GFRfhA6wNIWfpQ==
X-Google-Smtp-Source: AA6agR7iYr8HTflzB5me0MkRmvnvfYeC6NEJ6l7HP5sKFbAtQiONSlkryqRFPN1gOjYeKmeUHaOT2Q==
X-Received: by 2002:a17:902:e549:b0:174:d234:6116 with SMTP id n9-20020a170902e54900b00174d2346116mr19871188plf.131.1662065852382;
        Thu, 01 Sep 2022 13:57:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79d06000000b005379dd2deb5sm26442pfp.137.2022.09.01.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 13:57:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bradley Grove <linuxdrivers@attotech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] esas2r: Use flex array destination for memcpy()
Date:   Thu,  1 Sep 2022 13:57:29 -0700
Message-Id: <20220901205729.2260982-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; h=from:subject; bh=oUzuUGbXdkp1+ygGE/o7VtLMEMLuK7W2INwNNN66ZAM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjERy4i+Rf8Ayy4CrbV48DD/6X4DpAkroVm50Cj5uh sv71xE2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxEcuAAKCRCJcvTf3G3AJpDzEA Cd8W1sY7X84DJ0FrmFfuLa+ZjlQQUatfnd7b0ruJ68IJaDPeOBHvXksHzTL/lgsx7soHMIkKWKCSPu RrqxHmvFixKDblA8BpS7hbIIJeegU7sBtdnAki9ia8p9FApIdmXhPFyMMz2fM4FA3CyZgfnRayc48+ 6Smxu+Q99NPoleFhpCsmXinnnJTDd503wTO4NiGpTbcDWrPYeJ5e0x8GnUEAVROhULxlkRlbxpHqI3 6gqMM5Ph1XMND9OCIXJfZcYeLz7SvsMGOEHRmd4w8IhVI//X9y58Q2Cbsx8mY+wIVUgqOCfp85Dg6G m7W2S5lHhnXDb05xNwS5YGl7mS8ThrQ7nJE7lD33AfHhJJlYYgJn2gNah6DT4106PKIO6UcZaVByJE 8PWIl91PWIQ4QNPUqv0n/mnp6B/NP/Mg74OSl2CY0WJaDtHATF/jd20/8QyF4XZB+LlN9ET110uehr lSz3IVpK9tAaZFo0fceOl5ugCL817Up04qN0w+QP5s+DwzvfW5Pg/VgtL2SRHh7vz6odv0UTLW/t5H EuKeL51g+Fr4i1v/AUseF/TmkBqIbnSbs1a9skbGAqagXtVVvITH51oRMKmQYiTe2fICbLIuMHoaw+ A4CNBWPQU66jahnexI3eWPFDQFN/axCMKgHgkMo7CDFwpzIFY1NwOe8EebMw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In preparation for FORTIFY_SOURCE performing run-time destination buffer
bounds checking for memcpy(), specify the destination output buffer
explicitly, instead of asking memcpy() to write past the end of what
looked like a fixed-size object. Silences future run-time warning:

  memcpy: detected field-spanning write (size 80) of single field "trc + 1" (size 64)

There is no binary code output differences from this change.

Cc: Bradley Grove <linuxdrivers@attotech.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/esas2r/atioctl.h      | 1 +
 drivers/scsi/esas2r/esas2r_ioctl.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/esas2r/atioctl.h b/drivers/scsi/esas2r/atioctl.h
index ff2ad9b38575..dd3437412ffc 100644
--- a/drivers/scsi/esas2r/atioctl.h
+++ b/drivers/scsi/esas2r/atioctl.h
@@ -831,6 +831,7 @@ struct __packed atto_hba_trace {
 	u32 total_length;
 	u32 trace_mask;
 	u8 reserved2[48];
+	u8 contents[];
 };
 
 #define ATTO_FUNC_SCSI_PASS_THRU     0x04
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 08f4e43c7d9e..e003d923acbf 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -947,10 +947,9 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
 					break;
 				}
 
-				memcpy(trc + 1,
+				memcpy(trc->contents,
 				       a->fw_coredump_buff + offset,
 				       len);
-
 				hi->data_length = len;
 			} else if (trc->trace_func == ATTO_TRC_TF_RESET) {
 				memset(a->fw_coredump_buff, 0,
-- 
2.34.1

