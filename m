Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6453EF8E2
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Aug 2021 05:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhHRDzg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Aug 2021 23:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236518AbhHRDzf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 17 Aug 2021 23:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629258901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJUA5Ckkpg8eVrNC09NzqRZmcRDkZj6UhI0qH2WQAFI=;
        b=Tq3I7wcsKpRFMZmdaXz1kW7hwQ/K2+dVPOa+bDPDLY6epJpVnZF3d/tcNBUGdMU7Y9qU14
        xTxedmMU8dbxeaWwYGz6TAATMH3ipXs6NCUF9tQnj3QKSOyoGOnWVawE8aZ6OtYwk4fJRI
        3TDZX26yRojCQTPtAOpjNt9nfPxrwEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-0UxHiF7-OCGQuVpd4JzmnQ-1; Tue, 17 Aug 2021 23:53:20 -0400
X-MC-Unique: 0UxHiF7-OCGQuVpd4JzmnQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CBE3875047;
        Wed, 18 Aug 2021 03:53:18 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A9101036D2E;
        Wed, 18 Aug 2021 03:53:09 +0000 (UTC)
Date:   Wed, 18 Aug 2021 11:53:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH v2 04/11] blk-mq: Invert check in
 blk_mq_update_nr_requests()
Message-ID: <YRyEH562tYkKp643@T590>
References: <1628519378-211232-1-git-send-email-john.garry@huawei.com>
 <1628519378-211232-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628519378-211232-5-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Aug 09, 2021 at 10:29:31PM +0800, John Garry wrote:
> It's easier to read:
> 
> if (x)
> 	X;
> else
> 	Y;
> 
> over:
> 
> if (!x)
> 	Y;
> else
> 	X;
> 
> No functional change intended.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

