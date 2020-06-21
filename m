Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C71202BE2
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jun 2020 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgFURqL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Jun 2020 13:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730485AbgFURqL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 21 Jun 2020 13:46:11 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F30221E7;
        Sun, 21 Jun 2020 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592761570;
        bh=ALAY1kL3HOvixItCdKVfg4OQ+QcGUrLix48exQRbR2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFno9ZKxesX0cScIyDxV5cP/GmuIgeRrdZExcaUmv2GpkE8OQIzUhhz8foOF+hlSd
         rqTVZhAaXLrUBp+E3KsmcqwgHTCYIFY+BjlvCJlBJNqKkkLk/XrktaIZfHrIxc0Ygc
         LUah7xpfs+11ZXXCpH/oRMGFo5g+D6bTHKRWJsAY=
Date:   Sun, 21 Jun 2020 10:46:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v2 0/3] Inline Encryption support for UFS
Message-ID: <20200621174608.GA1140@sol.localdomain>
References: <20200618024736.97207-1-satyat@google.com>
 <yq1a70yh1f3.fsf@ca-mkp.ca.oracle.com>
 <SN6PR04MB4640005BEC3EE690CB904298FC960@SN6PR04MB4640.namprd04.prod.outlook.com>
 <SN6PR04MB46406FA71CAB5FC92E6DC744FC960@SN6PR04MB4640.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB46406FA71CAB5FC92E6DC744FC960@SN6PR04MB4640.namprd04.prod.outlook.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Jun 21, 2020 at 12:47:11PM +0000, Avri Altman wrote:
>  
> > +Alim & Asutosh
> > 
> > Hi Satya,
> > 
> > >
> > > Avri,
> > >
> > > > This patch series adds support for inline encryption to UFS using
> > > > the inline encryption support in the block layer. It follows the JEDEC
> > > > UFSHCI v2.1 specification, which defines inline encryption for UFS.
> > >
> > > I'd appreciate it if you could review this series.
> > >
> > > Thanks!
> > >
> > > --
> > > Martin K. Petersen      Oracle Linux Engineering
> > A quick question and a comment:
> > 
> > Does the IE infrastructure that you've added to the block layer invented for
> > ufs?
> And how this infrastructure relates to Eric's RFC: Inline crypto support on DragonBoard 845c
> https://www.spinics.net/lists/linux-scsi/msg141472.html 
> 

My patches are based on top of Satya's patches.  My patches just introduce the
quirks needed for Qualcomm ICE to work, since it doesn't follow the UFS standard
exactly.

- Eric
