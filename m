Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFDE145C50
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jan 2020 20:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAVTMs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Jan 2020 14:12:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50184 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgAVTMr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Jan 2020 14:12:47 -0500
Received: from localhost (unknown [62.209.224.147])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8B90115A0EB9F;
        Wed, 22 Jan 2020 11:12:45 -0800 (PST)
Date:   Wed, 22 Jan 2020 20:12:41 +0100 (CET)
Message-Id: <20200122.201241.1054821076123160712.davem@davemloft.net>
To:     kuba@kernel.org
Cc:     michal.kalderon@marvell.com, ariel.elior@marvell.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH net-next 13/14] qed: FW 8.42.2.0 debug features
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200122075416.608979b2@cakuba>
References: <20200122152627.14903-1-michal.kalderon@marvell.com>
        <20200122152627.14903-14-michal.kalderon@marvell.com>
        <20200122075416.608979b2@cakuba>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Jan 2020 11:12:46 -0800 (PST)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 22 Jan 2020 07:54:16 -0800

> On Wed, 22 Jan 2020 17:26:26 +0200, Michal Kalderon wrote:
>> Add to debug dump more information on the platform it was collected
>> from (kernel version, epoch, pci func, path id).
> 
> Kernel version and epoch don't belong in _device_ debug dump.

Agreed, this and the driver version bump stuff really has to go.
