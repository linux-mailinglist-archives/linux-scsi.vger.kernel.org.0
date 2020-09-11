Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC42662BB
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Sep 2020 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgIKP7X (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Sep 2020 11:59:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47313 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbgIKP6D (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 11 Sep 2020 11:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599839882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnqP80VfwQSbfZ7ARSC2y51Jf6mJED8b7AN6WRugtEg=;
        b=JghBkQNZLimbl7LmeSmcWHS0ljKNU1aJ0HfV+49FK0TPllbL6gdmgIdGwcYEYDepNIhHad
        aGi2S5NMJiALgkbP+7MMW3lZ4A2CdrVjUu2dnCAjQQQJlZw8sH7czbfhecKtcRdPhm2CgZ
        ZB+2dqKpIZC9+OcWfifYDUhR7UwT+QM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-On7d7XMZPnK4Ac2hIG2RpQ-1; Fri, 11 Sep 2020 09:44:03 -0400
X-MC-Unique: On7d7XMZPnK4Ac2hIG2RpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1771018C9F7E;
        Fri, 11 Sep 2020 13:44:02 +0000 (UTC)
Received: from ovpn-113-26.phx2.redhat.com (ovpn-113-26.phx2.redhat.com [10.3.113.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABC1B709E1;
        Fri, 11 Sep 2020 13:44:01 +0000 (UTC)
Message-ID: <adbb27fcbe0a534a9f19f4ff624f05dbf2a1a193.camel@redhat.com>
Subject: Re: [PATCH 1/1] scsi: scsi_dh_alua: remove the list entry before
 assigning the pointer and sdev to NULL
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Brian Bunker <brian@purestorage.com>, linux-scsi@vger.kernel.org
Cc:     hare@suse.de
Date:   Fri, 11 Sep 2020 09:44:01 -0400
In-Reply-To: <4064EB40-C84F-42E8-82F7-3940901C09D2@purestorage.com>
References: <4064EB40-C84F-42E8-82F7-3940901C09D2@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2020-09-10 at 14:22 -0700, Brian Bunker wrote:
> A race exists where the BUG_ON(!h->sdev) will fire if the detach
> device handler
> from one thread runs removing a list entry while another thread is
> trying to
> evaluate the target portal group state.
> 
> The order of the detach operation is now changed to delete the list
> entry
> before modifying the pointer and setting h->sdev to NULL.
> 
> Signed-off-by: Brian Bunker <brian@purestorage.com>
> Acked-by: Krishna Kant <krishna.kant@purestorage.com>
> ___
> diff -Naur a/scsi/drivers/scsi/device_handler/scsi_dh_alua.c
> b/scsi/drivers/scsi/device_handler/scsi_dh_alua.c
> --- a/scsi/drivers/scsi/device_handler/scsi_dh_alua.c	2020-09-10
> 12:29:03.000000000 -0700
> +++ b/scsi/drivers/scsi/device_handler/scsi_dh_alua.c	2020-09-10
> 12:41:34.000000000 -0700
> @@ -1146,16 +1146,18 @@
> 
>  	spin_lock(&h->pg_lock);
>  	pg = rcu_dereference_protected(h->pg, lockdep_is_held(&h-
> >pg_lock));
> -	rcu_assign_pointer(h->pg, NULL);
> -	h->sdev = NULL;
> -	spin_unlock(&h->pg_lock);
>  	if (pg) {
>  		spin_lock_irq(&pg->lock);
>  		list_del_rcu(&h->node);
>  		spin_unlock_irq(&pg->lock);
> -		kref_put(&pg->kref, release_port_group);
>  	}
> +	rcu_assign_pointer(h->pg, NULL);
> +	h->sdev = NULL;
> +	spin_unlock(&h->pg_lock);
>  	sdev->handler_data = NULL;
> +	if (pg) {
> +		kref_put(&pg->kref, release_port_group);
> +	}
>  	kfree(h);
>  }
> 

Good catch.

This makes the code hold the h->pg_lock while holding the pg->lock
though.

It seems like all that is needed is to remove the h->sdev = NULL
assignment, since it has to remain valid until the alua_ah_data is
removed from the pg->dh_list, and the object is going to be freed
right afterwards anyway?

Might as well also remove the BUG_ON(!h->sdev) in 2 places since the
kernel will crash when h is dereferenced anyway if it is NULL.

-Ewan


