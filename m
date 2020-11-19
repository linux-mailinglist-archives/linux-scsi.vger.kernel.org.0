Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D752B8F33
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 10:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgKSJnD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 04:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbgKSJnD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 19 Nov 2020 04:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605778982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cjfdvm5Tfse8jTWw5YoNVzoIaAqmnjpRqiwz0+jowt4=;
        b=UKsBBPyXpJ2j1VbA+Jt0LC/D+OUrNnl+pNQ+5Cv1PMOI5L5pMIW450tLZNUJy2GB9NbQDk
        ejXFDj4GVyxvvO6/YzM8Ql8+3H3v1WigKl+7PnkIThgaunXWj0sVVIdVmHT6qMGtF548EV
        wnxurY+2obcGFo3JmzIopnan/pxtmPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-iCkBv1ZPNd-59-2s06qvYw-1; Thu, 19 Nov 2020 04:42:58 -0500
X-MC-Unique: iCkBv1ZPNd-59-2s06qvYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2411906819;
        Thu, 19 Nov 2020 09:42:56 +0000 (UTC)
Received: from T590 (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D71705B4BC;
        Thu, 19 Nov 2020 09:42:47 +0000 (UTC)
Date:   Thu, 19 Nov 2020 17:42:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 00/13] blk-mq/scsi: tracking device queue depth via
 sbitmap
Message-ID: <20201119094242.GA279559@T590>
References: <20201119093402.279318-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119093402.279318-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Nov 19, 2020 at 05:33:49PM +0800, Ming Lei wrote:
> Hi,
> 

Looks this git-send-email is terminated  and the whole series isn't
sent out completely.

Please ignore this thread, will re-send soon.

Thanks,
Ming

