Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214EC22E20F
	for <lists+linux-scsi@lfdr.de>; Sun, 26 Jul 2020 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGZSjU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 Jul 2020 14:39:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43410 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGZSjU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 Jul 2020 14:39:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06QIbljR082852;
        Sun, 26 Jul 2020 18:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nApuHpVdBAEz1jxhBB90dQ9j80Nu0n3EgArkR+VtjhY=;
 b=q6QlSFjeHP+zEWE7bVbFrdE6zAiT3xDcgEy5fskqKtSocd9qJQs6SESBxh61nh7MnHw7
 YY2qFJWaXBuDt2Ly0ObtouQxGpwZOogGgmzdzWB3JClDlUGZyEvD36TlgvIFLhqm00gu
 6NhO2hFfBS8aXEcViSPjfdHJFZR+DURqDy5Y2hgza3cqf9FdsUIlh1zpFVqC39NQex0T
 8ahn06xBilHRwRn2bqClOCTHdWGa1Osc2uRJA/gGczW/PDDfZTvk4UxIztwQ7DTMS/1Z
 XrTfAdc8mSg5XqTO1KyZWATWLheKeQa43xU9zLdk7I5oCBsBC9uKarjkfCKzWdsS8Lt9 HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32gxd3hn7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 26 Jul 2020 18:39:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06QIJFMP092950;
        Sun, 26 Jul 2020 18:37:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32hdppbh5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jul 2020 18:37:16 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06QIbBN9017118;
        Sun, 26 Jul 2020 18:37:11 GMT
Received: from [20.15.0.8] (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Jul 2020 11:37:11 -0700
Subject: Re: [PATCH] scsi: target: loop: Fix handling of aborted TMRs
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200715160403.12578-1-bstroesser@ts.fujitsu.com>
 <795a006d-6d66-a635-7e76-601cb7807f5b@oracle.com>
 <2694d1fc-8792-0fe2-4dec-78f15d3b4ec5@ts.fujitsu.com>
From:   Mike Christie <michael.christie@oracle.com>
Message-ID: <90048ea8-3b8f-cc06-7869-dca645cd68f2@oracle.com>
Date:   Sun, 26 Jul 2020 13:37:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2694d1fc-8792-0fe2-4dec-78f15d3b4ec5@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007260145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007260146
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/26/20 6:02 AM, Bodo Stroesser wrote:
> On 2020-07-26 07:16, Mike Christie wrote:
>> On 7/15/20 11:04 AM, Bodo Stroesser wrote:
>>> Fix:
>>> After calling the aborted_task callback the core immediately
>>> releases the se_cmd that represents the ABORT_TASK. The woken
>>> up thread (tcm_loop_issue_tmr) therefore must not access se_cmd
>>> and tl_cmd in case of aborted TMRs.
>>
>> The code and fix description below look ok. I didn't get the above part though. If we have TARGET_SCF_ACK_KREF set then doesn't the se_cmd and tl_cmd stay around until we do the target_put_sess_cmd in tcm_loop_issue_tmr?
> 
> No. For an aborted ABORT_TASK, target_handle_abort is called.
> If tas is not set, it executes this code:
> 
>         } else {
>                 /*
>                  * Allow the fabric driver to unmap any resources before
>                  * releasing the descriptor via TFO->release_cmd().
>                  */
>                 cmd->se_tfo->aborted_task(cmd);
>                 if (ack_kref)
>                         WARN_ON_ONCE(target_put_sess_cmd(cmd) != 0);
>                 /*
>                  * To do: establish a unit attention condition on the I_T
>                  * nexus associated with cmd. See also the paragraph "Aborting
>                  * commands" in SAM.
>                  */
>         }
> 
>         WARN_ON_ONCE(kref_read(&cmd->cmd_kref) == 0);
> 
>         transport_lun_remove_cmd(cmd);
> 
>         transport_cmd_check_stop_to_fabric(cmd);
> 
> That means: no matter whether SCF_ACK_REF is set in the cmd or not:
> 1) fabric's aborted_task handler and a waiter woken up by aborted_task must not call target_put_sess_cmd.
> 2) a waiter woken up by aborted_task() must not access se_cmd (or tl_cmd) since target_handle_abort
>    might have released it completely meanwhile.
> 

Oh no, so xen has the same cmd lifetime issue as loop right?

And, it looks like iscsi has an issue too. I can hit both of those WARNs.

I'm ok with your patch, but is there a way to fix this in core for everyone?

It seems like something that must have worked at some point for everyone, but we broke. I'll try to get some time today and git bisect this to see if it's a regression.
