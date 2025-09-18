Return-Path: <linux-scsi+bounces-15678-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB3B15F88
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Jul 2025 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D756543D
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Jul 2025 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077AC285CAF;
	Wed, 30 Jul 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzu5HJXY"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB760264A7F;
	Wed, 30 Jul 2025 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875193; cv=none; b=Q4ZJ4NSONwLWy0RvO8yFjpXmEhuQcJLFWMSr9EOrNW7ItZMpz4CWbqrMX2fX0IxTXIZqo+EAvymkVaE3JVzXV+UfxhCHxV6SBCrm2P3YRqG6CeL43c3MT/mmgl+VzjDqUPP6v16WMWDKs7H9tSHEpv1/MkPWs199b6xQMGhz9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875193; c=relaxed/simple;
	bh=0ch3wD2Z47F0F7X58wFKGOUCAeW+CDgG+zpHUo2tKo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4BzTGLk/HcKiq0yqx5sHScsWpv6jV4v1vMEeJZgluEN6QQtFaq1q/0xp+XC+g1/pUkw3INYcaETtb2mV6d23Ay+wy1lZe3ntikfxgFk172oxIESNCU6hYCIgBB9clCfyOqzfqHmhvWqAAAmCdohBlh9id7KXmLEu99P34xNEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzu5HJXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1933C4CEE7;
	Wed, 30 Jul 2025 11:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753875193;
	bh=0ch3wD2Z47F0F7X58wFKGOUCAeW+CDgG+zpHUo2tKo4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kzu5HJXYvybAlXjdJRAFnNiZFhgPfbRtb2Xd46KAK5iJhNRDlwl+g2+9VZtVwiJrQ
	 IP8EWSv3rNLJZMi6pctoKCNkRXpZEyfhGd+El0knvArAdpuSd5QdD7aK59q4VW5taE
	 q4ifjmyVMxBTkGNTf75WvpaSJpzMlaTUFIeNdKJce4XjLyotkHgFW7QGNw17dnBA9k
	 XFVnHQ1Xt5oFvrxkVyT/FRg/z3nK1idf0U5u9S109q1OYO5SYTE05Q9malbikT9ptP
	 7LvDHUNvCBtuul7iueOaECQ3H4ITCDGZMsIcr9VuqmANrssAiJYO+E2ouYx0M+aISn
	 DIoRfLCjbc3Aw==
Message-ID: <bc07c850-c3ba-48bf-8ca2-a6ffda8440e8@kernel.org>
Date: Wed, 30 Jul 2025 13:33:08 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/3] dt-bindings: ufs: qcom: Add reg and reg-names
To: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, mani@kernel.org,
 alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730082229.23475-1-quic_rdwivedi@quicinc.com>
 <20250730082229.23475-2-quic_rdwivedi@quicinc.com>
 <466a42c4-54f5-45b2-b7f0-2d51695eac8e@kernel.org>
 <78998e50-a20c-41de-a2b8-a467475210cf@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <78998e50-a20c-41de-a2b8-a467475210cf@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/07/2025 12:27, Ram Kumar Dwivedi wrote:
> 
> 
> On 30-Jul-25 2:41 PM, Krzysztof Kozlowski wrote:
>> On 30/07/2025 10:22, Ram Kumar Dwivedi wrote:
>>> Update the Qualcomm UFS device tree bindings to support Multi-Circular
>>> Queue (MCQ) operation. This includes increasing the maximum number of
>>> register entries from 2 to 3 and extending the accepted values for
>>> reg-names to include "mcq_sqd" and "mcq_vs".
>>>
>>> These changes are required to enable MCQ support via Device Tree for
>>> platforms such as SM8650 and SM8750.
>>>
>>> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
>>> ---
>>>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 21 ++++++++++++-------
>>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> index 6c6043d9809e..de263118b552 100644
>>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> @@ -86,12 +86,17 @@ properties:
>>>  
>>>    reg:
>>>      minItems: 1
>>> -    maxItems: 2
>>> +    maxItems: 3
>>>  
>>>    reg-names:
>>> -    items:
>>> -      - const: std
>>> -      - const: ice
>>> +    oneOf:
>>> +      - items:
>>> +          - const: std
>>> +          - const: ice
>>> +      - items:
>>> +          - const: ufs_mem
>>> +          - const: mcq_sqd
>>> +          - const: mcq_vs
>>
>> This is incompatible change and commit msg is inaccurate here. It says
>> "extending" but you are not extending at all.
>>
>> Recent qcom patches love to break ABI and impact users. No.
>>
>> Best regards,
>> Krzysztof
> 
> 
> Hi Krzysztof,
> 
> Thanks for your feedback.
> 
> Regarding your concern about this being an incompatible change — could you please clarify what specific aspect you believe breaks compatibility? 
> From my side, I’ve carefully tested the patch and verified that it does not break any existing DTs. I ran the following command to validate against the schema:


I missed that earlier list is not actually used for SM8550 and SM8650.
The syntax is a bit confusing after looking only at diff, which probably
means this binding is getting messy.

I think binding should be just split the constraints are easier to follow.

Best regards,
Krzysztof

