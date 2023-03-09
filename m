Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FE6B2DBA
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Mar 2023 20:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCITcE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Mar 2023 14:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCITbU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 9 Mar 2023 14:31:20 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D6F64221
        for <linux-scsi@vger.kernel.org>; Thu,  9 Mar 2023 11:30:21 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id nn12so3048445pjb.5
        for <linux-scsi@vger.kernel.org>; Thu, 09 Mar 2023 11:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678390221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RbMXUm7pqAemtbTxFEHuwxSO+lKtdQq5rpNrosHYA8=;
        b=zywLGhIwJhUxyPiwCgU6fxI0qHWityOhStggUr8Yl460KreCyuk7CmJegOmDMrjI9i
         dhxuINtirFbBjGGn1nY0z73fh8mq7QGuzLRuh5nAcCR9tmL8p/RgidjPjpTvEavdCul3
         7rT0qcN1SqQw+FkrCtACzQeSVW3CCHeI5AXl7PsSoDwFIPT0+jZ/lLgMFjtOyYZMb3uZ
         CGN+T972NVx9RtfVodMbMwYAswTvrtBNfoCxix3uUUS9WOl40jULm8Xml2068OpRPv61
         U8IVk68gSdElw9SqL4zSeoO4Rb9A7uG6xrX7eapIt3JVjDXKEPlGmdmFMLuJtUv4Kk0E
         FOBA==
X-Gm-Message-State: AO0yUKVoGtNJ/xyzfXFXPsb08FiBwXRn5NccXpT7JjWNEJKSD5kuF7xJ
        2EPZzJSLI2witwb+weYxfhA=
X-Google-Smtp-Source: AK7set/kvwtk0XPO85K1dXozWfUu98lKLEVRs+vdeq4Bsr0hC9KT6Lk1d3kvGXLW84pgkdxk5pblIA==
X-Received: by 2002:a05:6a20:8b8f:b0:cd:6172:3b6 with SMTP id m15-20020a056a208b8f00b000cd617203b6mr18114322pzh.33.1678390220957;
        Thu, 09 Mar 2023 11:30:20 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bf9f:35c8:4915:cb24])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b0058d8f23af26sm11570955pff.157.2023.03.09.11.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 11:30:20 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charlie Sands <sandsch@northvilleschools.net>
Subject: [PATCH v2 78/82] scsi: rts5208: Declare SCSI host template const
Date:   Thu,  9 Mar 2023 11:26:10 -0800
Message-Id: <20230309192614.2240602-79-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230309192614.2240602-1-bvanassche@acm.org>
References: <20230309192614.2240602-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make it explicit that the SCSI host template is not modified.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/staging/rts5208/rtsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..db2dd0baa8be 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -191,7 +191,7 @@ static int device_reset(struct scsi_cmnd *srb)
  * this defines our host template, with which we'll allocate hosts
  */
 
-static struct scsi_host_template rtsx_host_template = {
+static const struct scsi_host_template rtsx_host_template = {
 	/* basic userland interface stuff */
 	.name =				CR_DRIVER_NAME,
 	.proc_name =			CR_DRIVER_NAME,
