Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7659166F
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Aug 2022 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbiHLUqb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Aug 2022 16:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiHLUq3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Aug 2022 16:46:29 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F9A00FE
        for <linux-scsi@vger.kernel.org>; Fri, 12 Aug 2022 13:46:28 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id f192so1891203pfa.9
        for <linux-scsi@vger.kernel.org>; Fri, 12 Aug 2022 13:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/UcmsqKNmLX0Et1eKGvS5F7PfMREwns7Em6/hhyTdtk=;
        b=FrTN1W0Nd9hxK25JSaSELzUiIRpd8JBO/u+LmQSZVgZj2BvEwEEsZasZzJph35OXg/
         nrUpqGohTMRERFToQ0QPkkbWx7Cuu0dGzNBkUAEdIXJJQiWzhWuGnfhZAJDBRbTSDhf1
         5PRt46r7457+Z8VxFZXxpWjC1dBNaoxeRbGj9vxk5fTs9jRoglOrrf91SGIGuHGc9C6Q
         ksYdIQrEBRT0CAJXf2x9OtZxPj9trWwsXk8MJwiKzvAqqWAlIiuYUiepCJ7eZFJDaKPK
         rtwY1M6M4Xwm5UqX5wQg98w01RbktBXuxYWoZcFUrV+6ZRc2TiPrU5ahx2wIZDBnfqq8
         pbgg==
X-Gm-Message-State: ACgBeo1N0Nw1BPnw5nf3B0PNbeF6QPNdPGqvnUgqMTcZr12PjUYM1H0V
        z1LMu+3u5zzyBVyG2ls6H4Q=
X-Google-Smtp-Source: AA6agR7ojNMg5qNfPzUDQAVEjxxEYsccHLbs07dn1nK67o3ChvJdjPab1+qmeVzD8kWKi0ZgJdJ4lg==
X-Received: by 2002:a63:584c:0:b0:41a:d4e2:f6d8 with SMTP id i12-20020a63584c000000b0041ad4e2f6d8mr4657917pgm.576.1660337187510;
        Fri, 12 Aug 2022 13:46:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a4e8800b001ef7c7564fdsm243189pjh.21.2022.08.12.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:46:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 4/4] scsi: core: Update a source code comment
Date:   Fri, 12 Aug 2022 13:45:53 -0700
Message-Id: <20220812204553.2202539-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220812204553.2202539-1-bvanassche@acm.org>
References: <20220812204553.2202539-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make sure that the 'proc_name' comment correctly reflects its new role.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/scsi/scsi_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 44af60cc19f3..6be7bfb037eb 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -353,7 +353,7 @@ struct scsi_host_template {
 
 
 	/*
-	 * Name of proc directory
+	 * Name reported via the proc_name SCSI host attribute.
 	 */
 	const char *proc_name;
 
