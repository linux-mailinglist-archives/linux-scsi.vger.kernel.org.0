Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B2F9E9E
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Nov 2019 00:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLX5N (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Nov 2019 18:57:13 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34238 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLX5M (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Nov 2019 18:57:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D14F12A6C6;
        Tue, 12 Nov 2019 18:57:09 -0500 (EST)
Date:   Wed, 13 Nov 2019 10:57:13 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Kars de Jong <jongk@linux-m68k.org>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        linux-m68k@vger.kernel.org, schmitzmic@gmail.com
Subject: Re: [PATCH 2/2] esp_scsi: Add support for FSC chip
In-Reply-To: <alpine.LNX.2.21.1.1911131007110.13@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1.1911131054110.19@nippy.intranet>
References: <20191029220503.7553-1-jongk@linux-m68k.org> <20191112185710.23988-1-jongk@linux-m68k.org> <20191112185710.23988-3-jongk@linux-m68k.org> <alpine.LNX.2.21.1.1911131007110.13@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 13 Nov 2019, Finn Thain wrote:

> 
> > +/* Values for the ESP family */
> 
> I would omit that comment.
> 

I see now that you meant "ESP family" in a narrow technical sense. I 
completely missed that. Maybe "Values for the ESP family bits" would make 
that clear.

-- 
