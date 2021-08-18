Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43A3EFDC4
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Aug 2021 09:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhHRH35 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Aug 2021 03:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238978AbhHRH3y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 18 Aug 2021 03:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629271757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wHdlhPVb5zDB2T7TPY+IaDHYh45fMOraPn2aUPWXsOA=;
        b=ZZfdCTlIsbta2lKS3lWm9Xi1mpDHAQj4e7rR1Ha4yszE63LcwvWBihP37uBDjVUhKSl8M9
        PyH9C5L1U+I//WMV5HWLAiDs9TooIyA0GZiiWHLDGqJuzi1JrT8aiAoPYBW4goMBr4LpJT
        K3Ymr80C3ujW1ArNLc4R6YmpH8i06QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-E_jdO8OqN_qkGlNMT1-Q0g-1; Wed, 18 Aug 2021 03:29:16 -0400
X-MC-Unique: E_jdO8OqN_qkGlNMT1-Q0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03277C73A0;
        Wed, 18 Aug 2021 07:29:15 +0000 (UTC)
Received: from T590 (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18A871AC7E;
        Wed, 18 Aug 2021 07:29:02 +0000 (UTC)
Date:   Wed, 18 Aug 2021 15:28:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH v2 07/11] blk-mq: Add
 blk_mq_tag_update_sched_shared_sbitmap()
Message-ID: <YRy2uAXiIwgfeK2u@T590>
References: <1628519378-211232-1-git-send-email-john.garry@huawei.com>
 <1628519378-211232-8-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628519378-211232-8-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Aug 09, 2021 at 10:29:34PM +0800, John Garry wrote:
> Put the functionality to update the sched shared sbitmap size in a common
> function.
> 
> Since the same formula is always used to resize, and it can be got from
> the request queue argument, so just pass the request queue pointer.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

