Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4173C3BBDF
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2019 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbfFJShN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Jun 2019 14:37:13 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57146 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbfFJShN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Jun 2019 14:37:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8C7768EE182;
        Mon, 10 Jun 2019 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560191832;
        bh=OLYm3aujlI1IBeRFl3fQU9bXSJ0zQ+ou0eKCe966Z7s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DG8/69vBPOYXSgfe4syUnnCvdxULGg2vnxGQKn5HavbdJYh5L0PPa4XaZLYmvfCE3
         /e/FEK5+o3IbOLJMyfNaOftBZNrHZXTPDrMD7K+gGwPknCEPj0XFYXZ+i9NIOb7Q6M
         dV056oxwdUc1R+bkug/RZuag/hbe9eE4VxHvAat8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yEo2dTI5CG4A; Mon, 10 Jun 2019 11:37:12 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 607BD8EE105;
        Mon, 10 Jun 2019 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560191831;
        bh=OLYm3aujlI1IBeRFl3fQU9bXSJ0zQ+ou0eKCe966Z7s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ov3nOn/D2yJagbz0Z8rMYTI55Hv6DIsgfazQypGb47jboiMWMyQwTYYivGI6e221g
         O1O9yllaRpMnd6lABSK/4r1/Z/y1ZUtf8mLM1f/4O/ADFxKzbtrYDbQqKmdNXGpawt
         330hEgsGdxZEzRWoVwhGYvkGo2ReI1Xp4etTzvjY=
Message-ID: <1560191829.3698.8.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Date:   Mon, 10 Jun 2019 11:37:09 -0700
In-Reply-To: <20190610150317.29546-3-ming.lei@redhat.com>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-06-10 at 23:03 +0800, Ming Lei wrote:
> The current way isn't safe for chained sgl, so use sgl helper to
> operate sgl.

The advansys driver doesn't currently use a chained scatterlist.  In
theory it could; the 

	if (shost->sg_tablesize > SG_ALL) {
		shost->sg_tablesize = SG_ALL;
	}

At around line 11226 is what prevents it and that could be eliminated
provided someone actually has the hardware to test.

However, provided drivers make the correct SG_ALL or less declaration,
they're entitled to treat scatterlists as fully contiguous, so there's
no real justification (beyond uniformity) for making it use the chain
helpers.

James

