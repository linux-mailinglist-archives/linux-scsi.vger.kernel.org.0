Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD372CC3B8
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 18:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgLBR2B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 12:28:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387569AbgLBR2B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Dec 2020 12:28:01 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2HA6YO038590;
        Wed, 2 Dec 2020 12:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=99mJ7FcmF7cE5LN73+rIbRWuUGG4atdwg82i/zSrrhk=;
 b=R26AJgX1VolGu5VKHvdcu2p7FVj2wqD58WPqw2tGZ7iil5bVfVa2+37H0u02R5TI/TMy
 oSeX0Va77RmYq7S4jzTdCWxIrUt6IlH29UMsTbuDonfZO92oVUD+1BSQOIdwnR3L2pzi
 cZiyK9Gnh800zqrOZdifY63jDM1YnNRPRo8Xpy62oyXvOSKAx+f10d54HCC6Sm7aS4Xs
 EGv+NLouk9gSrisSs72swsDltVLLBgHR1DLjuHe8RGZ7VV7gkBwyOfF2lAPlTeH7DKuO
 vOFyhuXXob1OOH1Q1seCJIuCtVlbVKZBHSbUIus5sr/i9VPl8muQ5lIZDLhHM3++Fsnw sg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 356ceu6649-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 12:27:15 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2HLVC8005047;
        Wed, 2 Dec 2020 17:27:14 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3569xuawra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 17:27:14 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2HRDNe11469410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 17:27:14 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE4A6112064;
        Wed,  2 Dec 2020 17:27:13 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21F78112061;
        Wed,  2 Dec 2020 17:27:12 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.65.215.138])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Dec 2020 17:27:11 +0000 (GMT)
Subject: Re: [PATCH v2 01/17] ibmvfc: add vhost fields and defaults for MQ
 enablement
To:     Brian King <brking@linux.vnet.ibm.com>,
        james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com
References: <20201202005329.4538-1-tyreld@linux.ibm.com>
 <20201202005329.4538-2-tyreld@linux.ibm.com>
 <a11c0e6a-cfa6-0dc4-5d34-6fd35ae1f29b@linux.vnet.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <38903a4f-9253-0b4b-6f67-af78ec86175f@linux.ibm.com>
Date:   Wed, 2 Dec 2020 09:27:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a11c0e6a-cfa6-0dc4-5d34-6fd35ae1f29b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_10:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020100
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 12/2/20 7:14 AM, Brian King wrote:
> On 12/1/20 6:53 PM, Tyrel Datwyler wrote:
>> Introduce several new vhost fields for managing MQ state of the adapter
>> as well as initial defaults for MQ enablement.
>>
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>> ---
>>  drivers/scsi/ibmvscsi/ibmvfc.c |  9 ++++++++-
>>  drivers/scsi/ibmvscsi/ibmvfc.h | 13 +++++++++++--
>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
>> index 42e4d35e0d35..f1d677a7423d 100644
>> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
>> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
>> @@ -5161,12 +5161,13 @@ static int ibmvfc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>>  	}
>>  
>>  	shost->transportt = ibmvfc_transport_template;
>> -	shost->can_queue = max_requests;
>> +	shost->can_queue = (max_requests / IBMVFC_SCSI_HW_QUEUES);
> 
> This doesn't look right. can_queue is the SCSI host queue depth, not the MQ queue depth.

Our max_requests is the total number commands allowed across all queues. From
what I understand is can_queue is the total number of commands in flight allowed
for each hw queue.

        /*
         * In scsi-mq mode, the number of hardware queues supported by the LLD.
         *
         * Note: it is assumed that each hardware queue has a queue depth of
         * can_queue. In other words, the total queue depth per host
         * is nr_hw_queues * can_queue. However, for when host_tagset is set,
         * the total queue depth is can_queue.
         */

We currently don't use the host wide shared tagset.

-Tyrel

> 
>>  	shost->max_lun = max_lun;
>>  	shost->max_id = max_targets;
>>  	shost->max_sectors = IBMVFC_MAX_SECTORS;
>>  	shost->max_cmd_len = IBMVFC_MAX_CDB_LEN;
>>  	shost->unique_id = shost->host_no;
>> +	shost->nr_hw_queues = IBMVFC_SCSI_HW_QUEUES;
>>  
>>  	vhost = shost_priv(shost);
>>  	INIT_LIST_HEAD(&vhost->sent);
> 
> 
> 

