Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52270256CA2
	for <lists+linux-scsi@lfdr.de>; Sun, 30 Aug 2020 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgH3HfG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 30 Aug 2020 03:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgH3HfG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 30 Aug 2020 03:35:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243402076D;
        Sun, 30 Aug 2020 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598772905;
        bh=Z/FmyEd9eHtomr5XbHkYpPD1417KzQFnCXSZgfQ4Z2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZNUvmUykyNDYQkeTDMM7k7xX6Q8qTwfuHNXRhJpwT3hFd72yxhzKbv2be1iUohkx
         zmtHbAcdIPmKrtNX8gpSqwzEgaZYAmV4Mw223NUF7w00kD4RQyAhtTKZ05n5zJYAkv
         BJeK9Rsq3ErIWcoaajLCvbBxSo2ktQSHCxveqQE4=
Date:   Sun, 30 Aug 2020 09:35:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 19/19] block: switch gendisk lookup to a simple xarray
Message-ID: <20200830073503.GB112265@kroah.com>
References: <20200830062445.1199128-1-hch@lst.de>
 <20200830062445.1199128-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830062445.1199128-20-hch@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Aug 30, 2020 at 08:24:45AM +0200, Christoph Hellwig wrote:
> Now that bdev_map is only used for finding gendisks, we can use
> a simple xarray instead of the regions tracking structure for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c         | 208 ++++++++----------------------------------
>  include/linux/genhd.h |   7 --
>  2 files changed, 37 insertions(+), 178 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
