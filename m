Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE06341C6
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFDI0y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 04:26:54 -0400
Received: from verein.lst.de ([213.95.11.211]:34254 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfFDI0y (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 04:26:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6395268B02; Tue,  4 Jun 2019 10:26:28 +0200 (CEST)
Date:   Tue, 4 Jun 2019 10:26:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] scsi: core: don't pre-allocate small SGL in case
 of NO_SG_CHAIN
Message-ID: <20190604082628.GA17205@lst.de>
References: <20190604082308.5575-1-ming.lei@redhat.com> <20190604082308.5575-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604082308.5575-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> +#ifndef CONFIG_ARCH_NO_SG_CHAIN
>  #define  SCSI_INLINE_PROT_SG_CNT  1
> -
>  #define  SCSI_INLINE_SG_CNT  2
> +#else
> +#define  SCSI_INLINE_PROT_SG_CNT  0
> +#define  SCSI_INLINE_SG_CNT  0
> +#endif

Please avoid the double negative and just use an ifdef.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
