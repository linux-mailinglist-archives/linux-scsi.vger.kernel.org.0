Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B93270B7E
	for <lists+linux-scsi@lfdr.de>; Sat, 19 Sep 2020 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISHnJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 19 Sep 2020 03:43:09 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35242 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISHnJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 19 Sep 2020 03:43:09 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 03:43:09 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 04B492243C;
        Sat, 19 Sep 2020 03:36:35 -0400 (EDT)
Date:   Sat, 19 Sep 2020 17:36:32 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
cc:     schmitzmic@gmail.com, linux@armlinux.org.uk, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: remove redundant initialization of variable ret
In-Reply-To: <20200918090747.44645-1-jingxiangfeng@huawei.com>
Message-ID: <alpine.LNX.2.23.453.2009191729360.9@nippy.intranet>
References: <20200918090747.44645-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 18 Sep 2020, Jing Xiangfeng wrote:

> The variable ret is being initialized with '-ENOMEM' that is
> meaningless. So remove it.
> 

Acked-by: Finn Thain <fthain@telegraphics.com.au>
