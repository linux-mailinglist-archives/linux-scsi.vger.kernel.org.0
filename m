Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2791D381664
	for <lists+linux-scsi@lfdr.de>; Sat, 15 May 2021 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhEOGso (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 15 May 2021 02:48:44 -0400
Received: from verein.lst.de ([213.95.11.211]:52579 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhEOGsn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 15 May 2021 02:48:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 363C268AFE; Sat, 15 May 2021 08:47:28 +0200 (CEST)
Date:   Sat, 15 May 2021 08:47:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH 01/50] core: Introduce the blk_req() function
Message-ID: <20210515064727.GA26723@lst.de>
References: <20210514213356.5264-1-bvanassche@acm.org> <20210514213356.5264-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514213356.5264-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> +/* Variant of blk_mq_rq_from_pdu() that verifies the type of its argument. */
> +static inline struct request *blk_req(struct scsi_cmnd *scmd)

Please don't use a blk_ prefix for a SCSI funtion.  Why not scsi_scmd_to_rq
or something like that?
