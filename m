Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42055390E26
	for <lists+linux-scsi@lfdr.de>; Wed, 26 May 2021 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhEZCHr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 May 2021 22:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhEZCHr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 25 May 2021 22:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621994776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VV4Ss7z7/W3+oPYMl74/kRFL2uVRCt+xRvsZmOIiQjk=;
        b=OVFi2zPWOzlLGgqe0NeyCRqePhsoJW66Wy/orSkd2LuLkmCWc+NdvHFFu5mkOzHZCbaJqz
        ErOr1dIVR3geyVjZWtBi/r3HAlBo2lb5vqMeX+/s3V97jk7Su12gYpye+Zx4dN8/Wjfrie
        l3pKDQrst5HuQ2XFyHURPfrbJVP0CfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-KFerlU3EPaaJtsW-Fxf3AQ-1; Tue, 25 May 2021 22:06:14 -0400
X-MC-Unique: KFerlU3EPaaJtsW-Fxf3AQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E52B0801817;
        Wed, 26 May 2021 02:06:12 +0000 (UTC)
Received: from T590 (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FE41687DF;
        Wed, 26 May 2021 02:06:03 +0000 (UTC)
Date:   Wed, 26 May 2021 10:05:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 5/8] block: split __blkdev_put
Message-ID: <YK2tB3+jcAkj7i9V@T590>
References: <20210525061301.2242282-1-hch@lst.de>
 <20210525061301.2242282-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525061301.2242282-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, May 25, 2021 at 08:12:58AM +0200, Christoph Hellwig wrote:
> Split __blkdev_put into one helper for the whole device, and one for
> partitions as well as another shared helper for flushing the block
> device inode mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

