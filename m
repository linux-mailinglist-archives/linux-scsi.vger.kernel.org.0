Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0C6A8D2D
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Mar 2023 00:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCBXoe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Mar 2023 18:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCBXoa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Mar 2023 18:44:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB4F94D
        for <linux-scsi@vger.kernel.org>; Thu,  2 Mar 2023 15:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677800622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2k+GP5w/mW8CW/5OpAFEff9AAlcLynxkVrT/Xx5WWIw=;
        b=bRL/qQTlFjetHO+/5suyezqtaNG7LXlje7RjavretnjaT3gB6hYmxsJR60t8AeCQBHue38
        gRTnr9z9V94NAn6YDmaxpWqmhEpSfst6tkuAiO34WA4VIh1YkHTAxSdoYG6kRmbFXkzkId
        2+VbrKKtwbIJUu+YAMbJOLiHssWFnHk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-VyW2eRu7NkWjkppiMPYgXg-1; Thu, 02 Mar 2023 18:43:39 -0500
X-MC-Unique: VyW2eRu7NkWjkppiMPYgXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15D773C0CD43;
        Thu,  2 Mar 2023 23:43:39 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.225.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63D2B140EBF6;
        Thu,  2 Mar 2023 23:43:38 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     sreekanth.reddy@broadcom.com, sathya.prakash@broadcom.com,
        ranjan.kumar@broadcom.com
Subject: [PATCH v2 1/6] scsi: mpi3mr: fix a memory leak
Date:   Fri,  3 Mar 2023 00:43:31 +0100
Message-Id: <20230302234336.25456-2-thenzl@redhat.com>
In-Reply-To: <20230302234336.25456-1-thenzl@redhat.com>
References: <20230302234336.25456-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a missing kfree.

Fixes: f10af057325c ("scsi: mpi3mr: Resource Based Metering")
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index ab8326b532e7..b632e1bb1007 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -4403,6 +4403,9 @@ void mpi3mr_free_mem(struct mpi3mr_ioc *mrioc)
 		mrioc->pel_seqnum_virt = NULL;
 	}
 
+	kfree(mrioc->throttle_groups);
+	mrioc->throttle_groups = NULL;
+
 	kfree(mrioc->logdata_buf);
 	mrioc->logdata_buf = NULL;
 
-- 
2.39.1

