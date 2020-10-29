Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41929F551
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Oct 2020 20:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJ2Tcr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Oct 2020 15:32:47 -0400
Received: from verein.lst.de ([213.95.11.211]:50076 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJ2Tcq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 29 Oct 2020 15:32:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BBE7067373; Thu, 29 Oct 2020 20:32:42 +0100 (CET)
Date:   Thu, 29 Oct 2020 20:32:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 02/18] block: open code kobj_map into in block/genhd.c
Message-ID: <20201029193242.GA4799@lst.de>
References: <20201029145841.144173-1-hch@lst.de> <20201029145841.144173-3-hch@lst.de> <20201029192236.GA991240@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029192236.GA991240@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Oct 29, 2020 at 08:22:36PM +0100, Greg Kroah-Hartman wrote:
> After this, you want me to get rid of kobj_map, right?  Or you don't
> care as block doesn't use it anymore?  :)

I have a patch to kill it, but it causes odd regressions with the
tpm driver according to the kernel test.  As I have grand plans that
build on the block ѕide of this series for 5.11, I plan to defer the
chardev side and address it for 5.12.
