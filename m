Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F212590
	for <lists+linux-scsi@lfdr.de>; Fri,  3 May 2019 02:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfECAhh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 May 2019 20:37:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbfECAhg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 May 2019 20:37:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x430Vq9v083787
        for <linux-scsi@vger.kernel.org>; Thu, 2 May 2019 20:37:35 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s88suma3t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 02 May 2019 20:37:35 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Fri, 3 May 2019 01:37:34 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 01:37:31 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x430bTJg54001874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 00:37:29 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79AD0C6055;
        Fri,  3 May 2019 00:37:29 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC896C6057;
        Fri,  3 May 2019 00:37:27 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.163.254])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 May 2019 00:37:27 +0000 (GMT)
Subject: Re: [PATCH 1/3] ibmvscsi: Wire up host_reset() in the drivers
 scsi_host_template
To:     Brian King <brking@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, brking@linux.ibm.com
References: <20190502004729.19962-1-tyreld@linux.ibm.com>
 <29e15e27-8cc6-d45e-a9e1-80603278dda2@linux.vnet.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Thu, 2 May 2019 17:37:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <29e15e27-8cc6-d45e-a9e1-80603278dda2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050300-0020-0000-0000-00000EE04410
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011037; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197736; UDB=6.00628229; IPR=6.00978592;
 MB=3.00026706; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-03 00:37:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050300-0021-0000-0000-000065A7CB16
Message-Id: <d21f91d4-20f7-5519-147d-0e4eb37004ae@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030002
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 05/02/2019 02:50 PM, Brian King wrote:
> On 5/1/19 7:47 PM, Tyrel Datwyler wrote:
>> From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>>
>> Wire up the host_reset function in our driver_template to allow a user
>> requested adpater reset via the host_reset sysfs attribute.
>>
>> Example:
>>
>> echo "adapter" > /sys/class/scsi_host/host0/host_reset
>>
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>> ---
>>  drivers/scsi/ibmvscsi/ibmvscsi.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
>> index 8cec5230fe31..1c37244f16a0 100644
>> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
>> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
>> @@ -2050,6 +2050,18 @@ static struct device_attribute ibmvscsi_host_config = {
>>  	.show = show_host_config,
>>  };
>>  
>> +static int ibmvscsi_host_reset(struct Scsi_Host *shost, int reset_type)
>> +{
>> +	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
>> +
>> +	vio_disable_interrupts(to_vio_dev(hostdata->dev));
>> +	dev_info(hostdata->dev, "Initiating adapter reset!\n");
>> +	ibmvscsi_reset_host(hostdata);
>> +	vio_enable_interrupts(to_vio_dev(hostdata->dev));
> 
> Is it necessary to disable / enable interrupts around the call to ibmvscsi_reset_host?
> I don't know why we'd need to do that before calling the reset as we have other
> cases, like ibmvscsi_timeout where we don't bother doing this. Also, at the end
> of the reset we look to be already enabling interrupts.

Yeah, I think you are right. My initial line of thought was that we have
interrupts disabled in handle_crq when we do a reset, but yeah we clearly call
it in the case of a timeout with them enabled.

-Tyrel

> 
> Thanks,
> 
> Brian
> 

