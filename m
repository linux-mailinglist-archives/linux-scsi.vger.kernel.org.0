Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB72D4D254A
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Mar 2022 02:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiCIBLv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Mar 2022 20:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiCIBLm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Mar 2022 20:11:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3CD8113D97
        for <linux-scsi@vger.kernel.org>; Tue,  8 Mar 2022 16:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646787242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LRdaBa2QKiuG4EBT2/d/M9ZBpb/k6yDqa1K8uu98Rcg=;
        b=PDvQ4XYGdrAIm+T2majGJLA5thIPwZyDeVGZyXK8BvoPTml6n0zqIHyAZVABZ4gHMRwHds
        7RNniUapQcC6AW8wSSvVin1f3KXaf2XlaDeEwEdO+/b4VvPem10q/A1l6ZJMDvVq2pMSns
        NhTw3tGNk4xdIjG1ZwwTz0GBbT9yWUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-ej1psXdBNDKwIqUSmkko1g-1; Tue, 08 Mar 2022 19:53:59 -0500
X-MC-Unique: ej1psXdBNDKwIqUSmkko1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 928E4801DDC;
        Wed,  9 Mar 2022 00:53:58 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0D384BC45;
        Wed,  9 Mar 2022 00:53:38 +0000 (UTC)
Date:   Wed, 9 Mar 2022 08:53:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, lduncan@suse.com, cleech@redhat.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [RFC PATCH 1/4] scsi: Allow drivers to set BLK_MQ_F_BLOCKING
Message-ID: <Yif6jjlpPTEYpcAT@T590>
References: <20220308003957.123312-1-michael.christie@oracle.com>
 <20220308003957.123312-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308003957.123312-2-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Mar 07, 2022 at 06:39:54PM -0600, Mike Christie wrote:
> The software iscsi driver's queuecommand can block and taking the extra
> hop from kblockd to its workqueue results in a performance hit. Allowing
> it to set BLK_MQ_F_BLOCKING and transmit from that context directly
> results in a 20-30% improvement in IOPs for workloads like:
> 
> fio --filename=/dev/sdb --direct=1 --rw=randrw --bs=4k --ioengine=libaio
> --iodepth=128  --numjobs=1
> 
> and for all write workloads.

This single patch shouldn't make any difference for iscsi, so please
make it as last one if performance improvement data is provided
in commit log.

Also is there performance effect for other worloads? such as multiple
jobs? iscsi is SQ hardware, so if driver is blocked in ->queuecommand()
via BLK_MQ_F_BLOCKING, other contexts can't submit IO to scsi ML any more.


thanks,
Ming

