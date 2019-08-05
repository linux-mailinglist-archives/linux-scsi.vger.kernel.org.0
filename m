Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC413823CC
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfHERPv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 13:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHERPv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 5 Aug 2019 13:15:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 784FDC0546D5;
        Mon,  5 Aug 2019 17:15:51 +0000 (UTC)
Received: from [10.10.121.197] (ovpn-121-197.rdu2.redhat.com [10.10.121.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E97C160CCE;
        Mon,  5 Aug 2019 17:15:50 +0000 (UTC)
Subject: Re: [RFC PATCH v2] target: tcmu: clean the nl_cmd of the udev when nl
 send fails
To:     Li Zhong <lizhongfs@gmail.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <5D446BC2.9000303@redhat.com>
 <20190805004336.16181-1-lizhongfs@gmail.com>
Cc:     martin.petersen@oracle.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D486446.8010807@redhat.com>
Date:   Mon, 5 Aug 2019 12:15:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190805004336.16181-1-lizhongfs@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 05 Aug 2019 17:15:51 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 08/04/2019 07:43 PM, Li Zhong wrote:
> If the userspace process crashes while we send the nl msg, it is possible
> that the cmd in curr_nl_cmd of tcmu_dev never gets reset to 0, and
> and returns busy for other commands after the userspace process is
> restartd.
> 
> More details below:
> 
> /backstores/user:file/file> set attribute dev_size=2048
> Cannot set attribute dev_size: [Errno 3] No such process
> /backstores/user:file/file> set attribute dev_size=2048
> Cannot set attribute dev_size: [Errno 16] Device or resource busy
> 
> with following kernel messages:
> [173605.747169] Unable to reconfigure device
> [173616.686674] tcmu daemon: command reply support 1.
> [173623.866978] netlink cmd 3 already executing on file
> [173623.866984] Unable to reconfigure device
> 
> Also, it is not safe to leave the nl_cmd in the list, and not get
> deleted.
> 
> This patch removes the nl_cmd from the list, and clear its data if
> it is not sent successfully.
> 
> Signed-off-by: Li Zhong <lizhongfs@gmail.com>


Acked-by: Mike Christie <mchristi@redhat.com>

