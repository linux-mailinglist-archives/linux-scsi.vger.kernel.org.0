Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14EB14E8D0
	for <lists+linux-scsi@lfdr.de>; Fri, 31 Jan 2020 07:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgAaGaj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 Jan 2020 01:30:39 -0500
Received: from verein.lst.de ([213.95.11.211]:43178 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgAaGaj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 Jan 2020 01:30:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E5F4868B20; Fri, 31 Jan 2020 07:30:35 +0100 (CET)
Date:   Fri, 31 Jan 2020 07:30:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH 2/6] scsi: remove .for_blk_mq
Message-ID: <20200131063035.GA18385@lst.de>
References: <20200119071432.18558-1-ming.lei@redhat.com> <20200119071432.18558-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119071432.18558-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Jan 19, 2020 at 03:14:28PM +0800, Ming Lei wrote:
> No one use it any more, so remove the flag.

Looks good modulo the subject typo, lets get this in ASAP even with
outstanding issue on the rest of the series:

Reviewed-by: Christoph Hellwig <hch@lst.de>
