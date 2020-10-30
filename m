Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0EE29FA53
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Oct 2020 02:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgJ3BIa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 29 Oct 2020 21:08:30 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:38684 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgJ3BIa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 29 Oct 2020 21:08:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5522E1280F20;
        Thu, 29 Oct 2020 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604019667;
        bh=ArhwSw02l2+zYA145GJrqD+OhHeXj1BmGxWm0ojTKrU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rpYTzHySxpyWzbtUH+BBoO84zPXHBs6A7L7owNJB6jmCqIs5THk9AqeMrxwOqZDOa
         lDwm70ioT3TEVJWwvj9OCJ6P22yBeIC0q8tUpTbg5afbFvDbRikwB2hiRgSO8O5SXZ
         Q1bMwLcOlx1CINqsKM/+2MmNDNy7+4p6PUvhaDJk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ETx2M70lPmub; Thu, 29 Oct 2020 18:01:07 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 54C7D1280F16;
        Thu, 29 Oct 2020 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604019667;
        bh=ArhwSw02l2+zYA145GJrqD+OhHeXj1BmGxWm0ojTKrU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rpYTzHySxpyWzbtUH+BBoO84zPXHBs6A7L7owNJB6jmCqIs5THk9AqeMrxwOqZDOa
         lDwm70ioT3TEVJWwvj9OCJ6P22yBeIC0q8tUpTbg5afbFvDbRikwB2hiRgSO8O5SXZ
         Q1bMwLcOlx1CINqsKM/+2MmNDNy7+4p6PUvhaDJk=
Message-ID: <202d1246a14617e4e7a4a7b723dc92191815d134.camel@HansenPartnership.com>
Subject: Re: [PATCH] z2ram: MODULE_LICENSE update and neatening
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Joe Perches <joe@perches.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Hannes Reinecke <hare@suse.de>
Date:   Thu, 29 Oct 2020 18:01:05 -0700
In-Reply-To: <4945b720d67e9f67b8c8ba02a29c6af1ffa15b08.camel@perches.com>
References: <20201029145841.144173-1-hch@lst.de>
         <20201029145841.144173-18-hch@lst.de>
         <4945b720d67e9f67b8c8ba02a29c6af1ffa15b08.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2020-10-29 at 17:11 -0700, Joe Perches wrote:
> This file still does not have an SPDX line.  What should it be?

It's old style MIT with a slight variation:

https://fedoraproject.org/wiki/Licensing:MIT#Old_Style

James




