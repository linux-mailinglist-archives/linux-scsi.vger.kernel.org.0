Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAF3FBB92
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Nov 2019 23:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfKMWZR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Nov 2019 17:25:17 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33638 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMWZQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 13 Nov 2019 17:25:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 32D392A6DA;
        Wed, 13 Nov 2019 17:25:14 -0500 (EST)
Date:   Thu, 14 Nov 2019 09:25:05 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Kars de Jong <jongk@linux-m68k.org>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        linux-m68k@vger.kernel.org, schmitzmic@gmail.com
Subject: Re: [PATCH 1/2] esp_scsi: Correct ordering of PCSCSI definition in
 esp_rev enum
In-Reply-To: <CACz-3rhWQgCXXCXcd-=+r09+WOPLs3FrcqcdYd3g=dYrci=ucw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1.1911140902360.21@nippy.intranet>
References: <20191029220503.7553-1-jongk@linux-m68k.org> <20191112185710.23988-1-jongk@linux-m68k.org> <20191112185710.23988-2-jongk@linux-m68k.org> <alpine.LNX.2.21.1.1911130946410.13@nippy.intranet>
 <CACz-3rhWQgCXXCXcd-=+r09+WOPLs3FrcqcdYd3g=dYrci=ucw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 13 Nov 2019, Kars de Jong wrote:

> >
> > FAS100A, FAST and FASHME are below both lines, which is a bit 
> > confusing.
> 
> Hmm, you're right. But I don't really know how to solve that. But if you 
> think the initial comment is enough to trigger people to investigate the 
> algorithm, I can remove them.
> 

Yes, please. The initial "NOTE!" that you added is sufficient, IMHO.

-- 
