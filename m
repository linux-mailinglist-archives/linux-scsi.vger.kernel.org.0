Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89437FF0C
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390590AbfHBQ6o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Aug 2019 12:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfHBQ6o (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 2 Aug 2019 12:58:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1ED3330FB8C3;
        Fri,  2 Aug 2019 16:58:44 +0000 (UTC)
Received: from [10.10.124.71] (ovpn-124-71.rdu2.redhat.com [10.10.124.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78FFB10016EA;
        Fri,  2 Aug 2019 16:58:43 +0000 (UTC)
Subject: Re: [RFC PATCH] target: tcmu: clean the nl_cmd of the udev when nl
 send fails
To:     Li Zhong <lizhongfs@gmail.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20190802103830.8881-1-lizhongfs@gmail.com>
Cc:     martin.petersen@oracle.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D446BC2.9000303@redhat.com>
Date:   Fri, 2 Aug 2019 11:58:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190802103830.8881-1-lizhongfs@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 02 Aug 2019 16:58:44 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 08/02/2019 05:38 AM, Li Zhong wrote:
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
> ---
>  drivers/target/target_core_user.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index 04eda111920e..4ae3103e204c 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -1708,6 +1708,24 @@ static int tcmu_init_genl_cmd_reply(struct tcmu_dev *udev, int cmd)
>  	return 0;
>  }
>  
> +static void tcmu_destroy_genl_cmd_reply(struct tcmu_dev *udev)
> +{
> +	struct tcmu_nl_cmd *nl_cmd = &udev->curr_nl_cmd;
> +
> +	if (!tcmu_kern_cmd_reply_supported)
> +		return;
> +
> +	if (udev->nl_reply_supported <= 0)
> +		return;
> +
> +	mutex_lock(&tcmu_nl_cmd_mutex);
> +
> +	list_del(&nl_cmd->nl_list);
> +	memset(nl_cmd, 0, sizeof(*nl_cmd));
> +
> +	mutex_unlock(&tcmu_nl_cmd_mutex);
> +}
> +
>  static int tcmu_wait_genl_cmd_reply(struct tcmu_dev *udev)
>  {
>  	struct tcmu_nl_cmd *nl_cmd = &udev->curr_nl_cmd;
> @@ -1788,6 +1806,9 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
>  	if (ret == 0 ||
>  	   (ret == -ESRCH && cmd == TCMU_CMD_ADDED_DEVICE))
>  		return tcmu_wait_genl_cmd_reply(udev);
> +	else
> +		/* If failure, remove from the list and clear the nl_cmd */

Drop the comment. We know it is in the failure path already and the
function name tells us it cleans up the command.

> +		tcmu_destroy_genl_cmd_reply(udev);
>  

