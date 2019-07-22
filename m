Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480EA6FEF6
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jul 2019 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfGVLuQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 07:50:16 -0400
Received: from verein.lst.de ([213.95.11.211]:59805 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbfGVLuQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 22 Jul 2019 07:50:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B0C568B20; Mon, 22 Jul 2019 13:50:14 +0200 (CEST)
Date:   Mon, 22 Jul 2019 13:50:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/3] fcoe: avoid memset across pointer boundaries
Message-ID: <20190722115013.GC32052@lst.de>
References: <20190722062231.115865-1-hare@suse.de> <20190722062231.115865-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722062231.115865-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 22, 2019 at 08:22:30AM +0200, Hannes Reinecke wrote:
> Gcc-9 complains for a memset across pointer boundaries, which happens
> as the code tries to allocate a flexible array on the stack.
> Turns out we cannot do this without relying on gcc-isms, so
> with this patch we'll embed the fc_rport_priv structure into
> fcoe_rport, can use the normal 'container_of' outcast, and
> will only have to do a memset over one structure.

This looks mostly good, but:

I think the subject and changelog are a bit odd.  What you do here
is to change that way how the private data is allocated by embeddeding
the fc_rport_priv structure into the private data, so that should be
the focus of the description.  That this was triggered by the memset
warning might be worth mentioning, but probably only after explaining
what you did.

> @@ -2738,10 +2736,7 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
>  {
>  	struct fip_header *fiph;
>  	enum fip_vn2vn_subcode sub;
> -	struct {
> -		struct fc_rport_priv rdata;
> -		struct fcoe_rport frport;
> -	} buf;
> +	struct fcoe_rport buf;

Wouldn't rport or frport be a better name for this variable?

>  	fiph = (struct fip_header *)skb->data;
> @@ -2757,7 +2752,8 @@ static int fcoe_ctlr_vn_recv(struct fcoe_ctlr *fip, struct sk_buff *skb)
>  		goto drop;
>  	}
>  
> -	rc = fcoe_ctlr_vn_parse(fip, skb, &buf.rdata);
> +	memset(&buf, 0, sizeof(buf));

Instead of the memset you could do an initialization at declaration
time:

	struct fcoe_rport rport = { };

> -	struct {
> -		struct fc_rport_priv rdata;
> -		struct fcoe_rport frport;
> -	} buf;
> +	struct fcoe_rport buf;
>  	int rc;
>  
>  	fiph = (struct fip_header *)skb->data;
>  	sub = fiph->fip_subcode;
> -	rc = fcoe_ctlr_vlan_parse(fip, skb, &buf.rdata);
> +	memset(&buf, 0, sizeof(buf));

Same two comments apply here.
