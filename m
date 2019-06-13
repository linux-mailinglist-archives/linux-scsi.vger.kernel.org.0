Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6343B16
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfFMP0V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 11:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfFMLsl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 07:48:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A58F21743;
        Thu, 13 Jun 2019 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560426520;
        bh=9qYuqWS/zB6QY0LmX9g1a0O0WQFIqul/r/81HJRNE7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avLatfaKqJJ+oNzBZHnPREm/5qpVln84VICPLPM2jMtQOD4IJ7ZEJnd28XA7S4/Vd
         xZU8/XYPYBzacMLk7AC6sRrlo5hCHgc7MEL6BqhRtTpoPWdk6Pr/ba8Z1HzsIjTtnd
         ylqwOLspOrBD6PP40k8i47Q1LF8jlqMLq1cheLBY=
Date:   Thu, 13 Jun 2019 13:48:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH V2 07/15] usb: image: microtek: use sg helper to operate
 sgl
Message-ID: <20190613114838.GA13444@kroah.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <20190613071335.5679-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613071335.5679-8-ming.lei@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 13, 2019 at 03:13:27PM +0800, Ming Lei wrote:
> The current way isn't safe for chained sgl, so use sg helper to
> operate sgl.

Same changelog comment problem as I mentioned on the other patch, please
fix up and resend.

thanks,

greg k-h
